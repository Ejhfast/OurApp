class Entry < ActiveRecord::Base
  belongs_to :request
  belongs_to :user
  has_one :winner
end
