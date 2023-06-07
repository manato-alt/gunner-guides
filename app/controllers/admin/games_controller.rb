class Admin::GamesController < Admin::BaseController
  def index
    @games = Game.page(params[:page]).per(10)
    
    if params[:title].present?
      @games = @games.where("title LIKE ?", "%#{params[:title]}%")
    end
  end

  def show
    @game = Game.find(params[:id])
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    if @game.update(game_params)
      redirect_to @game, notice: "ゲーム情報が更新されました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
  end


  private

  def game_params
    params.require(:game).permit(:title, :description, :logo_url)
  end
end
