class Project < ActiveRecord::Base
  has_many :photos, as: :owner

  attr_accessible :description, :name, :rating

  scope :open, where(completed_at: nil).order(:id)

  validates_presence_of :name, :description, :rating

  def length
    I18n.t("project.rating.#{rating}")
  end
end
