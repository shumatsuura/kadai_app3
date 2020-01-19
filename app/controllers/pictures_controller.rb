class PicturesController < ApplicationController
  before_action :set_picture, only:[:edit,:show,:update,:destroy]

  def index
    @pictures = Picture.all
  end

  def new
    if logged_in?
      @picture = Picture.new
    else
      redirect_to pictures_path, notice:"ログインしてくだい。"
    end
  end

  def create
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    if params[:back]
      render 'new'
    else
      if @picture.save
        NotificationMailer.notification_mail(@picture).deliver
        redirect_to pictures_path, notice:"投稿しました。"
      else
        render 'new'
      end
    end
  end

  def confirm
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    render 'new' if @picture.invalid?
  end

  def edit
    if logged_in?
      if not current_user.id == @picture.user_id
        redirect_to pictures_path, notice:"アクセス権限がありません。"
      end
    else
      redirect_to pictures_path, notice:"ログインしてください。"
    end
  end

  def update
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: "編集しました。"
    else
      render 'edit'
    end
  end

  def show
    if logged_in?
      @favorite = current_user.favorites.find_by(picture_id: @picture.id)
    end
  end

  def destroy
    if not current_user.id == @picture.user_id
      redirect_to pictures_path, notice:"権限がありません。"
    else
      @picture.destroy
      redirect_to pictures_path, notice:"削除しました"
    end
  end

  private

  def picture_params
    params.require(:picture).permit(:image,:image_cache, :content)
  end

  def set_picture
    @picture = Picture.find_by(id: params[:id])
  end
end
