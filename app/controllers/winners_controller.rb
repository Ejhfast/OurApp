class WinnersController < ApplicationController
  def show
  end
  
  def declare_winner
    @win = Winner.new
    eid = params[:entry_id].to_i
    @win.entry_id = eid
    if current_user.id == @win.entry.request.user.id && @win.entry.request.open
      @win.save
      @win.entry.request.open = false
      @win.entry.request.save
      tkarm = @win.entry.user.karma_total
      ckarm = @win.entry.user.karma_current
      @win.entry.user.karma_total = tkarm + @win.entry.request.karma
      @win.entry.user.karma_current = ckarm + @win.entry.request.karma
      @win.entry.user.save
    else
      flash[:error] = "You cannot declare a winner on this entry"
    end
    redirect_to entry_path(@win.entry)
  end
end
