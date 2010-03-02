class Request < ActiveRecord::Base
  
  undef_method :open
  
  after_create :reduce_users_karma
  
  
  has_many :entries
  has_many :commments
  belongs_to :user
  belongs_to :category
  
  named_scope :ordered, lambda {|*args| {:order => (args.first || 'created_at DESC')} }
  
  has_one :winner, :through => :entries  
  
  validates_presence_of     :title
  validates_presence_of     :category_id
  validates_presence_of     :user_id
  validates_numericality_of :karma
  validate :validate_karma
    
  def self.per_page
      25
  end
  
  def to_param
    "#{self.id}-#{self.title}" 
  end

  def tnum
    s = self.start.to_i
  end
  
  def inv_karma
    -1 * self.karma
  end
  
  def submitted_long_ago
    # determine how many minutes ago was this script created/submitted
    minutes_ago = (Time.now - self.start)/60
    if ( minutes_ago > 59)
       # determine how many hours ago was this script created/submitted
      hrs_ago = minutes_ago/60
      if (hrs_ago > 23)
         # determine how many days ago was this script created/submitted
        value = hrs_ago/24
        units = "days"
      else
        value = hrs_ago
        units = "hours"
      end
    else
      value = minutes_ago
      units = "minutes"
    end
    units.chop! if value.round == 1
    "#{value.round} #{units}" 
  end
  
  def validate_karma    
    if self.user
      errors.add(:karma, "You do not have enough karma!") unless (self.user.karma_current > karma or self.id)
    else
      errors.add(:user, "No user in request")
    end
  end
  
  def reduce_users_karma
    self.user.karma_current -= karma
    self.user.save
  end
  
  def self.find_by_categories(category_list, order)
    Request.find(:all, :include => :category, :conditions =>{"categories.name" => category_list}, :order => order)
  end
  
end
