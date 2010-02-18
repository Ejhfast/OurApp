class Friend < ActiveRecord::Base
  has_one :start_friend, :class => 'User', :foreign_key => :initiated
  has_one :on_friend, :class => 'User', :foreign_key => :received
  
end
