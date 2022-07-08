class Category < ApplicationRecord
  has_many :post_categoryships
  has_many :posts, through: :post_categoryships
end
