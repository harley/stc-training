class CommentsController < ApplicationController
  before_filter :load_user

  def index
    @comments = @user.comments
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = @user.comments.build
  end

  def create
    @comment = @user.comments.build(params[:comment])
    if @comment.save
      flash[:notice] = "New comment created."
      redirect_to [@user,@comment]
    else
      render :action => 'new'
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      flash[:notice] = "Successfully updated comment."
      redirect_to user_comment_path(@user,@comment)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = "Successfully destroyed comment."
    redirect_to user_comments_path(@user)
  end

  private 
  
  def load_user
    @user ||= User.find params[:user_id]
  end

end
