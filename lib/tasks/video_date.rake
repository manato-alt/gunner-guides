require 'google/apis/youtube_v3'
namespace :video_date do
  desc '動画情報をテーブルに保存'
  task save_videos: :environment do
    category = Category.find_by(name: 'setting')
    keywords = category.keywords
    game_name = GamesState.exists? ? GamesState.pluck(:title).first : []
    if game_name.empty?
      titles = Game.all.pluck(:title)
      titles.each do |title|
        GamesState.create(title: title)
      end
      game_name = GamesState.pluck(:title).first
    end
    game = Game.where(title: game_name).take
    client = Google::Apis::YoutubeV3::YouTubeService.new
    client.key = ENV['youtube_apy_key']
    youtube = client
    keywords.each do |keyword|
      query = "#{game_name} #{keyword.name}"
      results = youtube.list_searches('id,snippet', q: query, type: 'video', max_results: 10)

      results.items.each do |item|
        video_id = item.id.video_id
        video = youtube.list_videos('snippet,player', id: video_id).items.first

        # タイトルか概要欄にゲーム名とキーワードが含まれているか調べる
        unless video.snippet.title.include?(game_name) || video.snippet.description.include?(game_name) && video.snippet.title.include?(keyword.name) || video.snippet.description.include?(keyword.name)
          next
        end

        # 動画情報をデータベースに保存
        video_record = Video.new(
          title: video.snippet.title,
          thumbnail_url: video.snippet.thumbnails.default.url,
          embed_code: video.player.embed_html,
          game_id: game.id,
          category_id: keyword.category_id,
          video_id:
        )
        video_record.save unless Video.exists?(video_id:)
      end
    end
    #---------------------------------------------------------------------------------categoryをtrainingに変更
    category = Category.find_by(name: 'training')
    keywords = category.keywords
    keywords.each do |keyword|
      query = "#{game_name} #{keyword.name}"
      results = youtube.list_searches('id,snippet', q: query, type: 'video', max_results: 10)

      results.items.each do |item|
        video_id = item.id.video_id
        video = youtube.list_videos('snippet,player', id: video_id).items.first

        # タイトルか概要欄にゲーム名とキーワードが含まれているか調べる
        unless video.snippet.title.include?(game_name) || video.snippet.description.include?(game_name) && video.snippet.title.include?(keyword.name) || video.snippet.description.include?(keyword.name)
          next
        end

        # 動画情報をデータベースに保存
        video_record = Video.new(
          title: video.snippet.title,
          thumbnail_url: video.snippet.thumbnails.default.url,
          embed_code: video.player.embed_html,
          game_id: game.id,
          category_id: keyword.category_id,
          video_id:
        )
        video_record.save unless Video.exists?(video_id:)
      end
    end
    #---------------------------------------------------------------------------------categoryをinformationに変更
    category = Category.find_by(name: 'information')
    keywords = category.keywords
    keywords.each do |keyword|
      query = "#{game_name} #{keyword.name}"
      results = youtube.list_searches('id,snippet', q: query, type: 'video', max_results: 10)

      results.items.each do |item|
        video_id = item.id.video_id
        video = youtube.list_videos('snippet,player', id: video_id).items.first

        # タイトルか概要欄にゲーム名とキーワードが含まれているか調べる
        unless video.snippet.title.include?(game_name) || video.snippet.description.include?(game_name) && video.snippet.title.include?(keyword.name) || video.snippet.description.include?(keyword.name)
          next
        end

        # 動画情報をデータベースに保存
        video_record = Video.new(
          title: video.snippet.title,
          thumbnail_url: video.snippet.thumbnails.default.url,
          embed_code: video.player.embed_html,
          game_id: game.id,
          category_id: keyword.category_id,
          video_id:
        )
        video_record.save unless Video.exists?(video_id:)
      end
    end

    #---------------------------------------------------------------------------------
    GamesState.where(title: game_name).delete_all
  end
end
