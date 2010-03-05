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
  
  def leader
    users = {}
    User.find(:all).each do |user|
      points = user.karma_total
      users.merge!(Hash[user => points])
    end
    sorted_array_by_points = users.sort {|a,b| -1*(a[1] <=> b[1])}
    @users = []
    sorted_array_by_points.each do |array_element|
      @users << Hash[array_element[0], array_element[1]]
    end
    p @users
  end
  
end
