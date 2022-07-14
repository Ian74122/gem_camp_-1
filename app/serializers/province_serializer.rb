class ProvinceSerializer < ActiveModel::Serializer
  attributes :code , :name, :region
  belongs_to :region, serializer: RegionSerializer
end
