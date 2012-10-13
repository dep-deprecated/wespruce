class User < ActiveRecord::Base
  has_merit

  has_one :photo, as: :owner
  has_many :created_projects,   class_name: 'Project', foreign_key: :created_by
  has_many :cleaned_projects,   class_name: 'Project', foreign_key: :cleaned_by
  has_many :verified_projects,  class_name: 'Project', foreign_key: :verified_by

  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :username
  validates_uniqueness_of :username

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid      = auth.uid
      user.username = auth.info.nickname
      user.email    = auth.info.email
    end
  end

  def self.new_with_session(params, session)
    if session['devise.user_attributes']
      new(session['devise.user_attributes'], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def claim_project(project)
    project.cleaner = self
    project.accept!
  end

  def verify_project(project)
    raise ArgumentError.new("Can't verify your own work!") if project.cleaner == self
    project.verifier = self
    project.verify!
  end
end
