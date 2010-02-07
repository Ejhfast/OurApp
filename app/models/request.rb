class Request < ActiveRecord::Base
  
  undef_method :open
  
  has_many :entries
  has_many :commments
  belongs_to :user
  belongs_to :category
  
  named_scope :ordered, lambda {|*args| {:order => (args.first || 'created_at DESC')} }
  
  
  validates_presence_of     :title
  validates_presence_of     :category_id
  validates_presence_of     :user_id
  validates_numericality_of :karma
    
  public
  
  def inv_karma
    -1 * self.karma
  end
  
  def submitted_long_ago
    # determine how many minutes ago was this script created/submitted
    minutes_ago = (Time.now - self.created_at)/60
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
  
  def self.find_by_categories(category_list, order)
    Request.find(:all, :include => :category, :conditions =>{"categories.name" => category_list}, :order => order)
  end
  
end
