class Comment < ActiveRecord::Base
  belongs_to :entry
  belongs_to :request
end
