class EntriesController < ApplicationController
  
  before_filter :login_required
  
  def new
    # Select appropriate path (comments can be created from different sources)
    rid = params[:request_id]
    if rid != nil
      @path = request_entries_path
    else
      flash[:error] = "Entry must be attached to request."
      redirect_to root_path
    end
    @entry = Entry.new
  end

  def edit
    @entry = Entry.find(params[:id])
  end

  def show
    @entry = Entry.find(params[:id])
    if params[:request_id] == nil
      redirect_to request_path(@entry.request) + entry_path(@entry)
    end
  end

  def create
    @entry = Entry.new(params[:entry])
    
    # Logic to create a comment when given a request id as well:
    rid = params[:request_id]
    if rid != nil
      flash[:notice] = "In special logic"
      @entry.request_id = rid.to_i
    end
    
    success = @entry && @entry.save
    if success && @entry.errors.empty?
      redirect_to request_path(@entry.request) + entries_path
      flash[:notice] = "Entry created!"
    else
      flash[:error] = "We couldn't create your entry, sorry."
      render :action => 'new'
    end
  end

  def update
    @entry = Entry.find(params[:id])
    success = @entry && @entry.update_attributes(params[:entry])
    if success && @entry.errors.empty?
      redirect_to request_path(@entry.request) + entries_path
      flash[:notice] = "Entry updated!"
    else
      flash[:error] = "We couldn't update your entry, sorry."
      render :action => 'new'
    end
  end

  def destroy
    @entry = Entry.find(params[:id])
    rid = @entry.request.id
    @entry.destroy
    redirect_to request_path(rid) + entries_path
  end

  def index
    # Select appropriate path (comments can be created from different sources)
    rid = params[:request_id].to_i
    if rid != nil
      @path = new_request_entry_path
      @entries = Entry.find(:all, :conditions => {:request_id => rid})
      @req = Request.find(rid)
    else
      flash[:error] = "An entry must be attached to a request!"
      redirect_to requests_path
    end  
  end

end
