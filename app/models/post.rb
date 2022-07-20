class Post < ApplicationRecord

  validates_presence_of :title
  validates_presence_of :content

  has_many :comments
  belongs_to :user
  has_many :post_categoryships
  has_many :categories, through: :post_categoryships

  mount_uploader :image, ImageUploader

  after_create :generate_serial_number

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

  def generate_serial_number
    count_post_today = Post.where(created_at: DateTime.current.beginning_of_day..DateTime.current.end_of_day).count
    update(serial_number: "#{Date.current.strftime('%y%m%d')}#{count_post_today.to_s.rjust(4, '0')}")
  end
end
