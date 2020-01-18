class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id), notice: "Sign Upしました！"
    else
      render'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    if logged_in?
      if not current_user.id == @user.id
        redirect_to feeds_path, notice:"アクセス権限がありません。"
      end
    else
      redirect_to feeds_path, notice:"ログインしてください。"
    end



  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "編集しました。"
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email,:profile_photo,:profile_photo_cache, :password, :password_confirmation)
  end

end
