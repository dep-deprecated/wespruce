class Photo < ActiveRecord::Base
  belongs_to :owner, polymorphic: true

  has_attached_file :image
end
