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

  def generate_badge user
    output = "<div class='badge badge-#{user.sash_id}'>"
    if user.sash_id == 1
      output << "Reporter"
    elsif user.sash_id == 2
      output << "Cleaner"
    elsif user.sash_id == 3
      output << "Validator"
    elsif user.sash_id == 4
      output << "Full-day Warrior"
    end
    output << "</div>"

    return output.html_safe
  end 
end
