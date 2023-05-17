class UservideosController < ApplicationController
  def update
    @uservideo = Uservideo.find(params[:id])
    if @uservideo.watched_status == 1
      @uservideo.update(practiced_at: Time.now, watched_status: 2)
    else @uservideo.watched_status == 2
      @uservideo.update(practiced_at: nil, watched_status: 1)
    end
    render turbo_stream: turbo_stream.replace(
      'complete-button',
      partial: 'shared/watched_status',
    )
  end
end
