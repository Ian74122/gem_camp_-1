class Post < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :content

  has_many :comments
  belongs_to :user
  has_many :post_categoryships
  has_many :categories, through: :post_categoryships
end
