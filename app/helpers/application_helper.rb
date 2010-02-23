# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def open_req(req)
    req.open
  end
  
  def augment_image(url, options)
    if ["jpeg", "png", "gif"].select{|x| url.split(".").last.include?(x) }.empty?
      image_tag "/default.png", options
    else
      image_tag url, options
    end
  end
  
end
