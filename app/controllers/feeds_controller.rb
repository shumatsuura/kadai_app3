class FeedsController < ApplicationController
  before_action :set_feed, only:[:edit,:show,:update,:destroy]

  def index
    @feeds = Feed.all
  end

  def new
    if logged_in?
      @feed = Feed.new
    else
      redirect_to feeds_path, notice:"ログインしてくだい。"
    end
  end

  def create
    @feed = Feed.new(feed_params)
    @feed.user_id = current_user.id
    if params[:back]
      render 'new'
    else
      if @feed.save
        NotificationMailer.notification_mail(@feed).deliver
        redirect_to feeds_path, notice:"投稿しました。"
      else
        render 'new'
      end
    end
  end

  def confirm
    @feed = Feed.new(feed_params)
    @feed.user_id = current_user.id
    render 'new' if @feed.invalid?
  end

  def edit
    if logged_in?
      if not current_user.id == @feed.user_id
        redirect_to feeds_path, notice:"アクセス権限がありません。"
      end
    else
      redirect_to feeds_path, notice:"ログインしてください。"
    end
  end

  def update
    if @feed.update(feed_params)
      redirect_to feeds_path, notice: "編集しました。"
    else
      render 'edit'
    end
  end

  def show
    if logged_in?
      @favorite = current_user.favorites.find_by(feed_id: @feed.id)
    end
  end

  def destroy
    if not current_user.id == @feed.user_id
      redirect_to feeds_path, notice:"権限がありません。"
    else
      @feed.destroy
      redirect_to feeds_path, notice:"削除しました"
    end
  end

  private

  def feed_params
    params.require(:feed).permit(:image,:image_cache, :content)
  end

  def set_feed
    @feed = Feed.find_by(id: params[:id])
  end
end
