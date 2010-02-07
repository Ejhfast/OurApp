class Request < ActiveRecord::Base
  has_many :entries
  has_many :commments
  belongs_to :user
  
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
  
end
