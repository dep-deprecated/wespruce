module Permissions
  def self.permission_for(user)
    if user.nil?
      GuestPermission.new
    else
      MemberPermission.new(user)
    end
  end
end
