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
    @reqs = Request.ordered(sort_order[params[:sort]])
    @order = params[:sort]
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
    @order = params[:sort]
    @reqs = Request.find_by_categories(@selected_categories, sort_order[@order])
    @categories = Category.find(:all)
    render :action => "index"
  end
  
  private
  
  def find_all_categories
    Category.find(:all)
  end
  
	def sort_order 
	  {"karma" => "karma DESC", "old" => "end ASC", "new" => "end ASC", nil => nil}
  end
	
  

end
