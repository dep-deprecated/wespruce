class Project < ActiveRecord::Base
  include AASM

  belongs_to :creator,    class_name: 'User', foreign_key: :created_by
  belongs_to :cleaner,    class_name: 'User', foreign_key: :cleaned_by
  belongs_to :verifier,  class_name: 'User', foreign_key: :verified_by

  has_many :photos, as: :owner

  scope :open, where(completed_at: nil).order(:id)

  validates_presence_of :name, :description, :rating, :latitude, :longitude

  aasm column: :state do
    state :new, initial: true
    state :active
    state :completed, enter: :set_completed_at
    state :reopened,  enter: :remove_completed_at
    state :verified,  enter: :set_verified_at

    event :accept do
      transitions to: :active, from: :new, on_transition: :set_cleaner
    end

    event :complete do
      transitions to: :completed, from: [:active, :reopened]
    end

    event :reopen do
      transitions to: :reopened, from: :completed
    end

    event :verify do
      transitions to: :verified, from: :completed, on_transition: :set_verifier
    end
  end

  def length
    I18n.t("project.rating.#{rating}")
  end

  def remove_completed_at
    self.completed_at = nil
  end

  def set_cleaner(user)
    self.cleaner = user
  end

  def set_completed_at(time = Time.now)
    self.completed_at = time
  end

  def set_verified_at(time = Time.now)
    self.verified_at = time
  end

  def set_verifier(user)
    self.verifier = user
  end
end
