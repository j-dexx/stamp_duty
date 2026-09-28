require "bigdecimal"
require "bigdecimal/util"
require "forwardable"
require "stamp_duty/version"
require "stamp_duty/band"
require "stamp_duty/band_selector"
require "stamp_duty/band_amount"
require "stamp_duty/residential_calculator"

module StampDuty
  def self.for(price)
    price = normalize_price(price)
    bands = StampDuty::BandSelector.new(price).bands
    StampDuty::ResidentialCalculator.new(price, bands)
  end

  def self.normalize_price(price)
    unless price.is_a?(Numeric) && price.real?
      raise ArgumentError, "price must be a number, got #{price.inspect}"
    end
    raise ArgumentError, "price must be finite, got #{price.inspect}" unless price.finite?
    raise ArgumentError, "price must not be negative, got #{price.inspect}" if price.negative?

    price.is_a?(Rational) ? price.to_d(20) : price.to_d
  end
end
