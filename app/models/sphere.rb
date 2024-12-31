class Sphere < ApplicationRecord
  belongs_to :created_by, class_name: 'User'
  has_many :sphere_memberships
  has_many :users, through: :sphere_memberships
end
