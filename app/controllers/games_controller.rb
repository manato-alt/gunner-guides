class GamesController < ApplicationController
  def index
    @games = Game.page(params[:page]).per(12)
    
    if params[:title].present?
      @games = @games.where("title LIKE ?", "%#{params[:title]}%")
    end
  end

  def autocomplete
    if params[:q].present?
      query = "%#{params[:q]}%"
      @search_results = Game.where("title LIKE ?", query).pluck(:title)
    else
      @search_results = []
    end
    render partial: 'autocomplete', formats: :html
  end

  def show
    @game = Game.find_by!(title: params[:title])
  end
end
