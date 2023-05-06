class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find_by!(title: params[:title])
  end
end
