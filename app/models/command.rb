class Command < ApplicationRecord

  enum direction: {buy: 0, sell: 1}

  def self.seed(direction, currency, amount, price, price_percent: 1.0, check_time: 5*30)
    create(direction: direction, amount: amount, currency: currency, price: price,  price_percent: price_percent, check_time: check_time )
  end
end
