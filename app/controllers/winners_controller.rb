class WinnersController < ApplicationController
  def show
  end
  
  def declare_winner
    @win = Winner.new
    eid = params[:entry_id].to_i
    @win.entry_id = eid
    if current_user.id == @win.entry.request.user.id
      @win.save
      @win.entry.request.open = false
      @win.entry.request.save
    else
      flash[:error] = "You are not the creator of the entry #{current_user.id} vs #{@win.entry.request.user.id}"
    end
    redirect_to entry_path(@win.entry)
  end
end
