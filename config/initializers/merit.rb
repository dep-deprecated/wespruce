# Use this hook to configure merit parameters
Merit.setup do |config|
  # Check rules on each request or in background
  config.checks_on_each_request = false

  # Define ORM. Could be :active_record (default) and :mongo_mapper and :mongoid
  # config.orm = :active_record

  # Define :user_model_name. This model will be used to grand badge if no :to option is given. Default is "User".
  # config.user_model_name = "User"

  # Define :current_user_method. Similar to previous option. It will be used to retrieve :user_model_name object if no :to option is given. Default is "current_#{user_model_name.downcase}".
  # config.current_user_method = "current_user"
end

# Create application badges (uses https://github.com/norman/ambry)
Badge.create!({
  :id => 1,
  :name => 'active-user'
})

Badge.create!({
  :id => 2,
  :name => 'first-report'
})

Badge.create!({
  :id => 3,
  :name => 'first-validation'
})

Badge.create!({
  :id => 4,
  :name => '24-hours-work'
})

