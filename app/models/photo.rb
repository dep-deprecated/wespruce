class Photo < ActiveRecord::Base
  belongs_to :owner, polymorphic: true

  has_attached_file :image

  validates_attachment_presence     :image
  validates_attachment_size         :image, less_than: 5.megabytes
  validates_attachment_content_type :image, content_type: %w(image/jpeg image/png image/gif)
end
