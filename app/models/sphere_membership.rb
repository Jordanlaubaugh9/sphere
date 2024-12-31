class SphereMembership < ApplicationRecord
  belongs_to :user
  belongs_to :sphere
end
