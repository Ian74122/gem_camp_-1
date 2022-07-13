class WelcomeController < ApplicationController
  def say

  end

  def index
    @posts = Post.published.includes(:user, :categories).page(params[:page]).per(5)
    render 'posts/index'
  end
end
