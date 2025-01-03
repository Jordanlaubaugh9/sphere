class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :sphere_memberships
  has_many :spheres, through: :sphere_memberships

  # Allow anonymous users by making email/password optional
  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end

  # Allow blank passwords for anonymous users
  def password_required?
    false
  end
end
