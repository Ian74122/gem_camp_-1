class Region < ApplicationRecord
  validates_presence_of :code
  validates_presence_of :name
  validates_presence_of :region_name
  has_many :provinces
end
