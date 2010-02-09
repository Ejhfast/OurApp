class Category < ActiveRecord::Base
  has_many :requests
end
