class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  has_many :posts
  after_update :reload_geo_location!, if: :last_sign_in_ip_changed?

  def client?
    role == 'client'
  end

  def admin?
    role == 'admin'
  end

  def reload_geo_location!
    service = IpgeolocationIoService.new
    result = service.get_location(last_sign_in_ip)
    self.update_column(:country, result['country'])
    self.update_column(:city, result['city'])
  end
end
