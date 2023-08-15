require 'net/http'
require 'json'
require 'deepl'
namespace :fetch_shooting_game_data do
  desc 'Fetch and save shooting games data from Twitch and Giantbomb APIs'
  task save_shooting_games: :environment do
    twitch_access_token = Rails.cache.fetch('twitch_access_token', expires_in: 1.hour) do
      get_twitch_access_token
    end
    top_games = get_top_games(twitch_access_token)
    game_names = top_games['data'].map { |game| game['name'] }
    # ゲーム名を元に、カテゴリーがshooterのものを検索しデータベースに保存
    search_shooter_games(game_names)
  end

  def get_twitch_access_token
    uri = URI.parse('https://id.twitch.tv/oauth2/token')
    request = Net::HTTP::Post.new(uri)
    request.set_form_data(
      'client_id' => ENV['twitch_client_id'],
      'client_secret' => ENV['twitch_client_secret'],
      'grant_type' => 'client_credentials'
    )

    req_options = {
      use_ssl: uri.scheme == 'https'
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    JSON.parse(response.body)['access_token']
  end

  def get_top_games(twitch_access_token)
    uri = URI.parse('https://api.twitch.tv/helix/games/top')
    request = Net::HTTP::Get.new(uri)
    request['Authorization'] = "Bearer #{twitch_access_token}"
    request['Client-Id'] = ENV['twitch_client_id']
    request['limit'] = '20'

    req_options = {
      use_ssl: uri.scheme == 'https'
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    JSON.parse(response.body)
  end

  def translate_text(text)
    DeepL.configure do |config|
      config.auth_key = ENV['deepl_api_key']
      config.host = 'https://api-free.deepl.com' # Default value is 'https://api.deepl.com'
    end
    translation = DeepL.translate(text, nil, 'JA')
    translation.text
  end

  def search_shooter_games(game_names)
    shooter_games = []
    existing_titles = Game.pluck(:title)
    game_names -= existing_titles
    game_names.each do |name|
      url = URI.parse("https://www.giantbomb.com/api/search/?api_key=#{ENV['giantbomb_api_key']}&format=json&query=#{name}&resources=game")
      response = Net::HTTP.get(url)
      json = JSON.parse(response)
      next unless json['results'].present?

      game_id = json['results'][0]['id']

      # ゲームのタイトル、概要説明、ロゴ画像を取得
      url = URI.parse("https://www.giantbomb.com/api/game/#{game_id}/?api_key=#{ENV['giantbomb_api_key']}&field_list=name,deck,image&format=json")
      response = Net::HTTP.get(url)
      json = JSON.parse(response) if response.present?
      next unless json.present? && json['results'].present?

      game = {
        title: json['results']['name'],
        description: json['results']['deck'],
        logo_url: json['results']['image']['icon_url']
      }
      # ジャンルがシューティングの場合のみ追加
      url = URI.parse("https://www.giantbomb.com/api/game/#{game_id}/?api_key=#{ENV['giantbomb_api_key']}&field_list=genres&format=json")
      response = Net::HTTP.get(url)
      json = JSON.parse(response) if response.present?
      next unless json.present? && json['results'].present?

      genres = json['results']['genres']
      genres.each do |genre|
        next unless genre['name'].downcase.include?('shooter')

        game[:description] = translate_text(game[:description])
        shooter_games << game
        break
      end
    end
    shooter_games.each do |game|
      save_game(game)
    end
  end

  def save_game(game)
    # ゲームのタイトルがデータベースに存在するかどうかをチェック
    return unless Game.find_by(title: game[:title]).nil?

    Game.create(game)
  end
end
