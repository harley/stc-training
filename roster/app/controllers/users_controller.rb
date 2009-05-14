class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @roles = Role.all
    @user = User.new
    @roles = Role.all
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "New User Created."
      redirect_to @user
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    @roles = Role.all
  end

  def update
    params[:user][:role_ids] ||= []
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated user."
      redirect_to @user
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "Successfully destroyed user."
    redirect_to users_url
  end

  def logout
    reset_session
    CASClient::Frameworks::Rails::Filter.logout(self)
  end


end
