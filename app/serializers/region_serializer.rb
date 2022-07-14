class RegionSerializer < ActiveModel::Serializer
  attributes :code, :name, :region_name

  def code
    object.code
  end

  def name
    object.name
  end

  def region_name
    object.region_name
  end
end
