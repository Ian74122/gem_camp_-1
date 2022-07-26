class QueryUserGeoLocationJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    service = IpgeolocationIoService.new
    result = service.get_location(user.last_sign_in_ip)
    user.update_column(:country, result['country'])
    user.update_column(:city, result['city'])
  end
end
