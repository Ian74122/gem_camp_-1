class PhLocationService
  attr_reader :url
  def initialize
    @url = 'https://psgc.gitlab.io/api'
  end

  def get_regions
    response = RestClient.get("#{url}/regions")
    regions = JSON.parse(response.body)
    regions.each do |region|
      Region.find_or_create_by(code: region['code'], name: region['name'], region_name: region['regionName'])
    end
  end

  def get_provinces
    response = RestClient.get("#{url}/provinces")
    provinces = JSON.parse(response.body)
    provinces.each do |province|
      region = Region.find_by_code(province['regionCode'])
      Province.find_or_create_by(code: province['code'], name: province['name'], region: region)
    end
  end
end
