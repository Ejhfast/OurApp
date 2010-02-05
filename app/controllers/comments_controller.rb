class CommentsController < ApplicationController
  
  def new
    # Select appropriate path (comments can be created from different sources)
    rid = params[:request_id]
    if rid != nil
      @path = request_comments_path
    else
      @path = comments_path
    end
    @comment = Comment.new
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = Comment.new(params[:comment])
    
    # Logic to create a comment when given a request id as well:
    rid = params[:request_id]
    if rid != nil
      flash[:notice] = "In special logic"
      @comment.request_id = rid.to_i
    end
    
    success = @comment && @comment.save
    if success && @comment.errors.empty?
      redirect_to requests_path
      #flash[:notice] = "Request created!"
    else
      #flash[:error] = "We couldn't create your request, sorry."
      render :action => 'new'
    end
  end

  def update
    @comment = Comment.find(params[:id])
    success = @comment && @comment.update_attributes(params[:comment])
    if success && @comment.errors.empty?
      redirect_to comments_path # Just temporary, something more like 'back' would be better
      flash[:notice] = "Comment updated!"
    else
      flash[:error] = "We couldn't update your comment, sorry."
      render :action => 'new'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to comments_path # Just temporary, something more like 'back' would be better
  end

  def index
    # Select appropriate path (comments can be created from different sources)
    rid = params[:request_id]
    if rid != nil
      @path = new_request_comment_path
      @req = Request.find(rid)
      @comments = Comment.find(:all, :conditions => {:request_id => rid})
    else
      @path = new_comment_path
      @comments = Comment.all
    end  
  end
  

end
