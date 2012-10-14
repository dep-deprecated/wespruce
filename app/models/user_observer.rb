class UserObserver < ActiveRecord::Observer

  # Badge grant_to makes sure it only grants the badge once
  # Using an observer here because Merit's normal way of doing it defines
  # after_hooks on the controller which feels hacky to me.
  def after_save(user)
    # ActiveUser badge for any user with > 0 points
    Badge.find(1).grant_to(user) unless user.points.zero?

    if user.created_projects.any?
      Badge.find(2).grant_to(user)
    end

    if user.verified_projects.any?
      Badge.find(3).grant_to(user)
    end

    if user.cleaned_projects.verified.collect(&:to_time).sum >= 24.hours
      Badge.find(4).grant_to(user)
    end
  end
end
