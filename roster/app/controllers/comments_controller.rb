class CommentsController < ApplicationController
  before_filter :load_user

  def index
    if @user
      @comments = @user.comments
    else
      @comments = Comment.all
      render(:action => 'view_all') and return
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = @user.comments.build
  end

  def create
    @comment = @user.comments.build(params[:comment])
#    params[:comment][:user_id] = params[:user_id]
#    @comment = Comment.new(params[:comment])
    if @comment.save
      flash[:notice] = "New comment created."
      redirect_to user_comments_path(@user)
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
      redirect_to [@user,@comment]
    else
      render :action => 'edit'
    end
  end

  def destroy
    @comment = @user.comments.find(params[:id])
    @comment.destroy
    flash[:notice] = "Successfully destroyed comment."
    redirect_to comments_url
  end

private

  def load_user
    @user ||= User.find_by_id params[:user_id]
  end

end

