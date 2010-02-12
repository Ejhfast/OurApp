module RequestsHelper
  def category_list_item(category, selected_categories)
  	if !selected_categories.nil? and selected_categories.include?(category.name)
  		checked = true
		else
			checked = false
		end
		
		ret = ""
  	ret += check_box_tag('categories[]', category.name, checked) 
  	ret += category.name
  	ret += ""
	end 
	
	def sort_order_as_options(selected)
	  hash = {"karma" => "karma DESC", "old" => "end ASC", "new" => "end ASC"}
	  res = ""
	  sel = ""
	  hash.keys.each do |key|
	    if key == selected
	      sel = "selected"
      end
	    res += "<option value=#{key} #{sel}>#{key}</option>"
	    sel = ""
    end
    res
  end
  
end
