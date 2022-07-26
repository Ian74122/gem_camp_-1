class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  has_many :posts
  after_update :reload_geo_location!

  def client?
    role == 'client'
  end

  def admin?
    role == 'admin'
  end

  def reload_geo_location!
    QueryUserGeoLocationJob.perform_later(self.id)
  end
end
