class Project < ActiveRecord::Base
  has_many :photos, as: :owner

  attr_accessible :description, :name, :rating
end
