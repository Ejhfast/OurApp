class RequestsController < ApplicationController
  def new
    @req = Request.new
  end

  def edit
    @req = Request.find(params[:id])
  end

  def show
    @req = Request.find(params[:id])
  end

  def create
    @req = Request.new(params[:request])
    
    # I wish I could do this (check valid currency for request) in the model... Know how?
    
    if not enough_karma?(@req.user, @req.karma)
      flash[:error] = "Not enough karma!"
      return redirect_to requests_path
    end
    
    success = @req && @req.save
    if success && @req.errors.empty?
      @req.user.karma_current = @req.user.karma_current - @req.karma
      @req.user.save
      redirect_to requests_path
      flash[:notice] = "Request created!"
    else
      flash[:error] = "We couldn't create your request, sorry."
      render :action => 'new'
    end
  end

  def update
    @req = Request.find(params[:id])
    success = @req && @req.update_attributes(params[:request])
    if success && @req.errors.empty?
      redirect_to requests_path
      flash[:notice] = "Request updated!"
    else
      flash[:error] = "We couldn't update your request, sorry."
      render :action => 'new'
    end
  end

  def destroy
    @req = Request.find(params[:id])
    @req.destroy
    redirect_to requests_path
  end

  def index
    @reqs = Request.all
    @categories = Category.find(:all)
    @selected_categories = @categories.map{|category| category.name} if @selected_categories.blank?
    respond_to do |format|
      format.html
      format.xml {render :xml => @requests}
      @requests= Request
    end
  end
  
  def filter_by_category
    @selected_categories = params[:categories]
    @reqs = Request.find_by_categories(@selected_categories)
    @categories = Category.find(:all)
    render :action => "index"
  end
  
  private
  
  def find_all_categories
    Category.find(:all)
  end
  

end
