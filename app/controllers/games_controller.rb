# frozen_string_literal: true

# Controller for managing games in the application.
class GamesController < ApplicationController
  def index
    @games = Game.page(params[:page]).per(12)

    return unless params[:title].present?

    @games = @games.where('title LIKE ?', "%#{params[:title]}%")
  end

  def autocomplete
    if params[:q].present?
      query = "%#{params[:q]}%"
      @search_results = Game.where('title LIKE ?', query).pluck(:title)
    else
      @search_results = []
    end
    render partial: 'autocomplete', formats: :html
  end

  def show
    @game = Game.find_by!(title: params[:title])
  end
end
