# frozen_string_literal: true

require "bigdecimal"
require "bigdecimal/util"
require "stamp_duty/version"
require "stamp_duty/band"
require "stamp_duty/band_amount"
require "stamp_duty/rates"
require "stamp_duty/calculation"

module StampDuty
  # Calculates Stamp Duty Land Tax on a residential purchase in England or
  # Northern Ireland.
  def self.for(price, first_time_buyer: false, additional_property: false, non_resident: false)
    price = normalize_price(price)
    bands = Rates.bands_for(
      price,
      first_time_buyer: boolean!(first_time_buyer, :first_time_buyer),
      additional_property: boolean!(additional_property, :additional_property),
      non_resident: boolean!(non_resident, :non_resident)
    )
    Calculation.build(price, bands)
  end

  def self.normalize_price(price)
    unless price.is_a?(Numeric) && price.real?
      raise ArgumentError, "price must be a number, got #{price.inspect}"
    end
    raise ArgumentError, "price must be finite, got #{price.inspect}" unless price.finite?
    raise ArgumentError, "price must not be negative, got #{price.inspect}" if price.negative?

    price.is_a?(Rational) ? price.to_d(20) : price.to_d
  end

  def self.boolean!(value, name)
    return value if value == true || value == false

    raise ArgumentError, "#{name} must be true or false, got #{value.inspect}"
  end
  private_class_method :normalize_price, :boolean!
end
