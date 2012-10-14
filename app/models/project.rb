class Project < ActiveRecord::Base
  include AASM
  reverse_geocoded_by :latitude, :longitude

  REWARD_POINTS = {1 => 1, 2 => 3, 3 => 12, 4 => 50, 5 => 100}.freeze

  belongs_to :creator,  class_name: 'User', foreign_key: :created_by
  belongs_to :cleaner,  class_name: 'User', foreign_key: :cleaned_by
  belongs_to :verifier, class_name: 'User', foreign_key: :verified_by

  after_create :assign_reporter_points

  has_many :photos, as: :owner, dependent: :destroy
  accepts_nested_attributes_for :photos, reject_if: ->(attributes) { attributes['image'].blank? }

  scope :open,      where(completed_at: nil)
  scope :verified,  where(state: 'verified')
  scope :completed, where(state: 'completed')
  scope :active,    where(state: 'active')

  validates_presence_of :name, :description, :rating, :latitude, :longitude

  aasm column: :state do
    state :new, initial: true
    state :active
    state :completed, enter: :set_completed_at
    state :reopened,  enter: :remove_completed_at
    state :verified,  enter: :set_verified_at

    event :accept do
      transitions to: :active, from: :new, :guard => :has_cleaner?
    end

    event :complete do
      transitions to: :completed, from: [:active, :reopened]
    end

    event :reopen do
      transitions to: :reopened, from: :completed
    end

    event :verify do
      transitions to: :verified, from: :completed, on_transition: :assign_points
    end
  end

  def can_add_cleaned_photos?(user)
    self.cleaned_by == user.id && self.state != 'verified'
  end

  def editable?(user)
    self.created_by == user.id && self.state == 'new'
  end

  def length
    I18n.t("project.rating.#{rating}")
  end

  def new_photo_state
    self.state == 'new' ? 'before' : 'after'
  end

  def remove_completed_at
    self.completed_at = nil
  end

  def set_cleaner(user)
    self.cleaner = user
  end

  def has_cleaner?
    self.cleaner.present?
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

  def assign_reporter_points
    creator.increment(:points, 1)
    creator.save
  end

  def assign_points
    cleaner.increment(:points, REWARD_POINTS[self.rating])
    cleaner.save
  end

  def to_time
    case rating
    when 1
      15.minutes
    when 2
      60.minutes
    when 3
      2.hours
    when 4
      4.hours
    when 5
      8.hours
    end
  end
end
