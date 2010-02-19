class HomeController < ApplicationController
  def index
    @user = User.new
  end
  
  def render_signup
    @user = User.new
  end
  
  def about
  end
  
  def ethan
  end
  
end
