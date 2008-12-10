# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # custom extender method for the facebooker
  # fb_name method which adds an :ifcantsee parameter
  def custom_fb_name(user, options = {})
    fb_name(user,
            {:ifcantsee => "a secret scholar"}.merge(options))
  end

  def wrap_in_fbml_tags(text)
    "<fb:fbml>#{text}</fb:fbml>"
  end

end
