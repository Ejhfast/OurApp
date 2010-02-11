class CategoriesController < ApplicationController
  before_filter :login_required
  before_filter :is_admin
  
  def new
     @cat = Category.new
   end

   def edit
     @cat = Category.find(params[:id])
   end

   def show
     @cat = Category.find(params[:id])
   end

   def create
     @cat = Category.new(params[:category])
     success = @cat && @cat.save
     if success && @cat.errors.empty?
       redirect_to categories_path
       flash[:notice] = "Category created!"
     else
       flash[:error] = "We couldn't create your category, sorry."
       render :action => 'new'
     end
   end

   def update
     @cat = Category.find(params[:id])
     success = @cat && @cat.update_attributes(params[:category])
     if success && @cat.errors.empty?
       redirect_to categories_path
       flash[:notice] = "Category updated!"
     else
       flash[:error] = "We couldn't update your request, sorry."
       render :action => 'new'
     end
   end

   def destroy
     @cat = Category.find(params[:id])
     @cat.destroy
     redirect_to categories_path
   end

   def index
     @categories = Category.all
   end
   
   def is_admin
     if not current_user.admin
       flash[:error] = "Only an admin can add categories"
       redirect_to root_path
     end
   end
end
