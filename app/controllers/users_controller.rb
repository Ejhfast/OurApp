class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  

  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def show
    @user = User.find(params[:id])
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!"
    else
      flash[:error] = "We couldn't create your account, sorry."
      render :action => 'new'
    end
  end
  
  def update
    @user = User.find(params[:id])
    success = @user && @user.update_attributes(params[:user])
    if success && @user.errors.empty?
      redirect_to root_path
      flash[:notice] = "Account updated!"
    else
      flash[:error] = "We couldn't update your account, sorry."
      render :action => 'new'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end
  

end
