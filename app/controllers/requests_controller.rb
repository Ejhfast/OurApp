class RequestsController < ApplicationController
  
  before_filter :login_required, :except => [:index, :show, :filter_by_category]
  
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
    success = @req && @req.save
    if success && @req.errors.empty?
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
    @order = params[:sort]
    @selected_categories = params[:categories]
    @categories = Category.find(:all)
    @selected_categories = @categories.map{|category| category.name} if @selected_categories.blank?
    @reqs = Request.paginate :all, :include => :category, 
                             :conditions =>{"categories.name" => @selected_categories}, 
                             :order => sort_order[@order], :page => params[:page]
  end
  

  private
  
  def find_all_categories
    Category.find(:all)
  end
  
	def sort_order 
	  {"karma" => "karma DESC", "old" => "end ASC", "new" => "end ASC", nil => nil}
  end
	
  

end
