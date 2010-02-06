module RequestsHelper
  def category_list_item(category, selected_categories)
  	if !selected_categories.nil? and selected_categories.include?(category.name)
  		checked = true
		else
			checked = false
		end
		
		ret = "<li>"
  	ret += check_box_tag('categories[]', category.name, checked) 
  	ret += category.name
  	ret += "</li>"
	end 
  
end
