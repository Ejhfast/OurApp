# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  def enough_karma?(user, karma)
    if user.karma_current > karma
      true
    else
      false
    end
  end
  
  def add_karma(user, karma, f)
    user.karma_current = user.karma_current + karma * f
    user.karma_total = user.karma_total + karma * f
    user.save
  end
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
