# frozen_string_literal: true

module Admin
  # Controller for managing games in the admin panel.
  class GamesController < Admin::BaseController
    # Lists all games with optional title filtering.
    def index
      @games = Game.page(params[:page]).per(10)

      return unless params[:title].present?

      @games = @games.where('title LIKE ?', "%#{params[:title]}%")
    end

    # Displays details of a specific game.
    def show
      @game = Game.find(params[:id])
    end

    # Renders the edit form for a game.
    def edit
      @game = Game.find(params[:id])
    end

    # Updates game information based on user input.
    def update
      @game = Game.find(params[:id])
      if @game.update(game_params)
        redirect_to @game, notice: 'ゲーム情報が更新されました。'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # Deletes a game from the system.
    def destroy
      @game = Game.find(params[:id])
      @game.destroy
    end

    private

    # Strong parameters for game attributes.
    def game_params
      params.require(:game).permit(:title, :description, :logo_url)
    end
  end
end
