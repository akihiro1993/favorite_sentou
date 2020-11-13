class UsersController < ApplicationController

  def index
  @users = User.all
  @all_ranks = User.find(Post.group(:user_id).order('count(user_id) desc').limit(5).pluck(:user_id))
  end

  def show
  @user = User.find(params[:id])
  @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_path(user.id)
  end

  def destroy
  end

  def followerindex
     @user = User.find(params[:id])
  end

  def followedindex
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
