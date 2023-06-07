class Admin::VideosController < Admin::BaseController
  def index
    @videos = Video.page(params[:page]).per(10)

    if params[:title].present?
      @videos = @videos.where("title LIKE ?", "%#{params[:title]}%")
    end

    # ゲームIDで絞り込み
    if params[:game_id].present?
      @videos = @videos.where(game_id: params[:game_id])
    end

    # カテゴリIDで絞り込み
    if params[:category_id].present?
      @videos = @videos.where(category_id: params[:category_id])
    end


  end

  def show
    @video = Video.find(params[:id])
  end

  def edit
    @video = Video.find(params[:id])
  end

  def update
    @video = Video.find(params[:id])
    if @video.update(video_params)
      redirect_to edit_admin_video_path(@video), notice: "動画情報が更新されました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy
  end


  private

  def video_params
    params.require(:video).permit(:thumbnail_url, :title)
  end
end
