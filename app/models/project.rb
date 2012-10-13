class Project < ActiveRecord::Base
  has_many :photos, as: :owner

  attr_accessible :description, :name, :rating

  scope :open, where(completed_at: nil).order(:id)
end
