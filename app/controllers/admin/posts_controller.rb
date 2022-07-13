class Admin::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def index

  end

  private
  
  def check_admin
    unless current_user.admin?
      flash[:notice] = "You do not have permission"
      redirect_to posts_path
    end
  end
end
