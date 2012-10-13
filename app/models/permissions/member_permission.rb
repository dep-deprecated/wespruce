module Permissions
  class MemberPermission < BasePermission
    def initialize(user)
      allow_all
    end
  end
end
