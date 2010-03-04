class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  
  def index
    @users = User.find(:all, :order => "karma_total DESC")
  end

  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def show
    @id = params[:id]
    @user = User.find(@id)
    @winners = @user.entries.select{|x| x.winner}
    @requests = @user.requests
    @entries = @user.entries
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    if params[:user] == "quick"
      @user.password_confirmation = @user.password
    end
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
  
  def gallery
    @user = User.find(params[:id])
    @winners = @user.entries.select{|x| x.winner}
  end
  

end
