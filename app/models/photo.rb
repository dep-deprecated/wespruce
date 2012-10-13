class Photo < ActiveRecord::Base
  belongs_to :owner, polymorphic: true

  has_attached_file :image

  attr_accessible :kind, :owner_id, :owner_type
end
