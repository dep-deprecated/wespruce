module ApplicationHelper
  def meaning_of_rating rating
    if rating > 0
      output = "A #{rating}-star rating means this is a "
      if rating == 1
        output << "very easy task that should only take a couple of minutes."
      elsif rating == 2
        output << "fairly simple task that should take under an hour."
      elsif rating == 3
        output << "somewhat involved task that may take a 2-3 hours."
      elsif rating == 4
        output << "pretty difficult task that may take half a day or so."
      elsif rating == 5
        output << "very difficult task that will likely take most of the day."
      end
    else
      output = "A star rating gives you an idea of project complexity. 1 star is a quick task. 5 stars may take all day."
    end

    return output.html_safe
  end

  def generate_badge badge
    output = "<div class='badge badge-#{badge.id}'>"
    case badge.id
    when 1
      output << "Reporter"
    when 2
      output << "Cleaner"
    when 3
      output << "Validator"
    when 4
      output << "Full-day Warrior"
    end
    output << "</div>"

    return output.html_safe
  end 

  def notice_tag
    return unless flash[:notice].present?
    content_tag(:div, 'class' => 'text-warning') do
      flash.notice
    end
  end

  def error_tag
    return unless flash[:error].present?
    content_tag(:div, 'class' => 'text-error') do
      flash.error
    end

  end

  def static_google_map_with_marker(lat, lng, opts = {})
    latlng_str = [lat, lng].join(',')
    opts[:size] ||= "325x325"
    opts[:zoom] ||= "16"

    param_str = opts.map { |k,v| "&#{k}=#{v}" }.join

    "http://maps.google.com/maps/api/staticmap?center=#{latlng_str}#{param_str}&markers=color:green%7Clabel:+%7C#{latlng_str}&sensor=false"
  end

end
