# frozen_string_literal: true

require "forwardable"

module StampDuty
  # The tax due on the part of a purchase price that falls within one band.
  BandAmount = Data.define(:band, :taxable_amount) do
    extend Forwardable

    def_delegators :band, :lower_bound, :upper_bound, :percentage_rate, :decimal_percentage_rate, :description

    def self.for(band, price)
      new(band: band, taxable_amount: band.taxable_amount(price))
    end

    def amount
      decimal_percentage_rate * taxable_amount
    end

    def to_h
      {
        description: description,
        lower_bound: lower_bound,
        upper_bound: upper_bound,
        percentage_rate: percentage_rate,
        taxable_amount: taxable_amount,
        amount: amount
      }
    end
  end
end
