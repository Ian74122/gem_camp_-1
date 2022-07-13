class Post < ApplicationRecord

  validates_presence_of :title
  validates_presence_of :content

  has_many :comments
  belongs_to :user
  has_many :post_categoryships
  has_many :categories, through: :post_categoryships

  mount_uploader :image, ImageUploader

  include AASM
  aasm column: :state do
    state :pending, initial: true
    state :inspecting, :published

    event :check do
      transitions from: :pending, to: :inspecting
    end

    event :publish do
      transitions from: :inspecting, to: :published
    end

    event :edit do
      transitions from: :published, to: :pending
    end
  end
end
