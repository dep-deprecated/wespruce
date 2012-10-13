class Photo < ActiveRecord::Base
  attr_accessible :kind, :owner_id, :owner_type
end
