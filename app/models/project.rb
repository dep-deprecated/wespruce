class Project < ActiveRecord::Base
  belongs_to :creator,    class_name: 'User', foreign_key: :created_by
  belongs_to :cleaner,    class_name: 'User', foreign_key: :cleaned_by
  belongs_to :validator,  class_name: 'User', foreign_key: :validated_by

  has_many :photos, as: :owner

  scope :open, where(completed_at: nil).order(:id)

  validates_presence_of :name, :description, :rating, :latitude, :longitude

  def length
    I18n.t("project.rating.#{rating}")
  end
end
