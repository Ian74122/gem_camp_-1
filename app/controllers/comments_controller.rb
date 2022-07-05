class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: [:edit, :update, :destroy]

  def index
    @comments = @post.comments
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post = @post
    if @comment.save
      redirect_to post_comments_path(@post)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to post_comments_path(@post, @comment)
    else
      render :edit
    end
  end

  def destroy
    if @comment.destroy
      redirect_to post_comments_path(@post)
    end
  end

  private

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def set_post
    @post = Post.find params[:post_id]
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
