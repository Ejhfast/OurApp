class Entry < ActiveRecord::Base
  belongs_to :request
  belongs_to :user
  has_one :winner
  
  validates_presence_of :title
  validates_presence_of :request_id
  
  has_attached_file :submission, 
                      :styles => { :large => "600x600>",
                                   :medium => "300x300>",
                                   :thumb => "100x100>" }
                                   
end
