class UserObserver < ActiveRecord::Observer

  # Badge grant_to makes sure it only grants the badge once
  # Using an observer here because Merit's normal way of doing it defines 
  # after_hooks on the controller which feels hacky to me.
  def after_save(user)
    Badge.find(1).grant_to(user) unless user.points.zero?
  end
end
