class WinnersController < ApplicationController
  
  before_filter :login_required
  
  
  def show
  end
  
  def declare_winner
    @win = Winner.new
    eid = params[:entry_id].to_i
    @win.entry_id = eid
    if current_user.id == @win.entry.request.user.id && @win.entry.request.open
      @win.save
      # Close entry
      @win.entry.request.open = false
      @win.entry.request.save
      # Give Karma to winner
      add_karma(@win.entry.user, @win.entry.request.karma, 2)
      
      #tkarm = @win.entry.user.karma_total
      #ckarm = @win.entry.user.karma_current
      #@win.entry.user.karma_total = tkarm + @win.entry.request.karma * 2
      #@win.entry.user.karma_current = ckarm + @win.entry.request.karma * 2
      #@win.entry.user.save
      
      # Give Karma to Others
      @win.entry.request.entries.each do |other|
        add_karma(other.user, @win.entry.request.karma, 1)
      end
    else
      flash[:error] = "You cannot declare a winner on this entry"
    end
    redirect_to entry_path(@win.entry)
  end
end
