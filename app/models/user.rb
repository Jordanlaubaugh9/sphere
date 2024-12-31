class User < ApplicationRecord
  has_many :sphere_memberships
  has_many :spheres, through: :sphere_memberships
end
