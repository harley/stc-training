class UsersController < ApplicationController
  def index
    @users = User.all.sort_by{|u| u.name}
  end

  def show
    @user = User.find(params[:id])
  end

  def new
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

  def mass_add
  end

  def mass_create
    errors = User.mass_add(params[:netids])
    unless errors.empty?
      flash[:error] = "Import of the following users failed:<br /> "+(errors.join "<br />")
    end
    redirect_to users_path
  end

  def update
		# to make it update when you uncheck all roles on the form
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
