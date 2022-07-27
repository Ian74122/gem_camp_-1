class Order < ApplicationRecord
  belongs_to :user
  validates :amount, numericality: { greater_than: 0 }

  include AASM
  aasm column: :state do
    state :pending, initial: true
    state :submitted, :failed, :revoked, :paid
    event :submit do
      transitions from: :pending, to: :submitted
    end
    event :fail do
      transitions from: %i[pending submitted], to: :failed
    end
    event :revoked do
      transitions from: %i[pending submitted], to: :revoked
    end
    event :pay do
      transitions from: :submitted, to: :paid, success: :revise_balance!
    end
  end

  def revise_balance!
    user.update(balance: user.balance + amount)
  end
end
