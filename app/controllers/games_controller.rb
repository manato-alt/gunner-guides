class GamesController < ApplicationController
  def index
    @games = Game.page(params[:page]).per(12)
    
    if params[:title].present?
      @games = @games.where("title LIKE ?", "%#{params[:title]}%")
    end
  end

  def show
    @game = Game.find_by!(title: params[:title])
  end
end
