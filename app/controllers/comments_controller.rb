class CommentsController < ApplicationController
  
  def get_comment_thing
    if params[:request_id] != nil
      @thing = Request.find(params[:request_id])
      @thing_path = request_path(@thing)
      @path = request_comments_path
      @comments = Comment.find(:all, :conditions => {:request_id => params[:request_id]})  
      [@thing, @thing_path, @path, @comments]
    elsif params[:entry_id] != nil
      @thing = Entry.find(params[:entry_id])
      @thing_path = entry_path(@thing)
      @path = entry_comments_path
      @comments = Comment.find(:all, :conditions => {:entry_id => params[:entry_id]})  
      [@thing, @thing_path, @path, @comments]
    else
      flash[:error] = "No entry?"
      ["a","b", "c", "d"]
    end
  end
  
  def new
    # Select appropriate path (comments can be created from different sources)
    @thing, @thing_path, @path, @comments = get_comment_thing
    @path = @thing_path + comments_path
    @comment = Comment.new
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def show
    @comment = Comment.find(params[:id])
    @thing, @thing_path, @path, @comments = get_comment_thing
    @path = @path + '/new'
  end

  def create
    @comment = Comment.new(params[:comment])
    @thing, @thing_path, @path, @comments = get_comment_thing
    
    
    # Logic to create a comment when given another id as well:
    if params[:request_id] != nil
      @comment.request_id = params[:request_id].to_i
    elsif params[:entry_id] != nil
      @comment.entry_id = params[:entry_id].to_i
    else
      flash[:notice] = "Comment must be attached to entry or request"
      redirect_to root_path
    end
    
    success = @comment && @comment.save
    if success && @comment.errors.empty?
      redirect_to @path
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
      redirect_to request_path(@comment.request) + comments_path
      flash[:notice] = "Comment updated!"
    else
      flash[:error] = "We couldn't update your comment, sorry."
      render :action => 'new'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @thing, @thing_path, @path, @comments = get_comment_thing
    @comment.destroy
    redirect_to entry_comments_path # Just temporary, something more like 'back' would be better
  end

  def index
    @thing, @thing_path, @path, @comments = get_comment_thing
    @path = @path + "/new"
    if @thing == nil
      flash[:error] = "#{@thing} #{@thing_path} #{@path}"
      redirect_to root_path
    end
  end
  

end
