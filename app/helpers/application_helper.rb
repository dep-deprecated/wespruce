module ApplicationHelper
  def meaning_of_rating rating
    output = "A <strong>#{rating}-star</strong> rating means this is a "
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
    return output.html_safe
  end
end
