class ProvinceSerializer < ActiveModel::Serializer
  attributes :code , :name, :region

  def region
    RegionSerializer.new(object.region)
  end
end
