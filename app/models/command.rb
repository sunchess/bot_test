class Command < ApplicationRecord

  enum direction: {buy: 0, sell: 1}

  attr_accessor :duplicate

  def self.seed(direction, symbol, amount, price, price_percent: 1.0, check_time: 5*30, duplicate: false)
    record = create(direction: direction, amount: amount, symbol: symbol, price: price,  price_percent: price_percent, check_time: check_time)
    return record.errors.full_messages if record.errors.any?
  end

  validates_presence_of :symbol, :direction, :amount, :price, :side1, :side2
  validate :check_on_duplicate

  def check_on_duplicate
    errors.add(:symbol, "Seems you try to add duplicate order") if !self.duplicate and self.class.find_by(direction: self.direction, amount: self.amount, symbol: self.symbol, price: self.price)
    false
  end

  before_validation :init_sides

  def init_sides
    self.side1 = self.symbol[0..2]
    self.side2 = self.symbol[3..-1]
  end

  class << self
    private

    def timestamp_attributes_for_create
      super << 'inserted_at'
    end

  end
end
