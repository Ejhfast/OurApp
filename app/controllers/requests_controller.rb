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
    success = @req && @req.save
    if success && @req.errors.empty?
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
  end

end
