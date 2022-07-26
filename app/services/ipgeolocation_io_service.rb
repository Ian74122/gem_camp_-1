class IpgeolocationIoService
  attr_reader :url, :key
  def initialize
    @url = "https://api.ipgeolocation.io"
    @key = "86e923b61fb44197afd57193b85644d9"
  end

  def get_location(ip)
    request_url = "#{url}/ipgeo?apiKey=#{key}&ip=#{ip}"
    response = RestClient.get(request_url)
    JSON.parse(response.body)
  end
end