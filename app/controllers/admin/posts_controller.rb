class Admin::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def index
    @posts = Post.includes(:user, :categories).inspecting
  end

  def publish
    @post = Post.find_by_id(params[:post_id])
    if @post.may_publish?
      @post.publish!
      flash[:notice] = "this order state change to publishing"
      redirect_to admin_posts_path
    end
  end

  private

  def check_admin
    authorize current_user, :check_admin?, policy_class: AdminPolicy
  end
end
