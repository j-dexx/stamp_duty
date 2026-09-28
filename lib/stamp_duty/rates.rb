# frozen_string_literal: true

module StampDuty
  # Residential SDLT rates for England and Northern Ireland from 1 April 2025.
  # https://www.gov.uk/stamp-duty-land-tax/residential-property-rates
  module Rates
    STANDARD = [
      Band.new(lower_bound: 0, upper_bound: 125_000, percentage_rate: 0),
      Band.new(lower_bound: 125_000, upper_bound: 250_000, percentage_rate: 2),
      Band.new(lower_bound: 250_000, upper_bound: 925_000, percentage_rate: 5),
      Band.new(lower_bound: 925_000, upper_bound: 1_500_000, percentage_rate: 10),
      Band.new(lower_bound: 1_500_000, upper_bound: nil, percentage_rate: 12)
    ].freeze

    FIRST_TIME_BUYER = [
      Band.new(lower_bound: 0, upper_bound: 300_000, percentage_rate: 0),
      Band.new(lower_bound: 300_000, upper_bound: 500_000, percentage_rate: 5)
    ].freeze

    # First-time buyer relief cannot be claimed above this price.
    FIRST_TIME_BUYER_MAX_PRICE = 500_000

    # Surcharges only apply to purchases of at least this price.
    SURCHARGE_MIN_PRICE = 40_000

    ADDITIONAL_PROPERTY_SURCHARGE = 5
    NON_RESIDENT_SURCHARGE = 2

    def self.bands_for(price, first_time_buyer:, additional_property:, non_resident:)
      if first_time_buyer && additional_property
        raise ArgumentError, "first-time buyer relief cannot apply to an additional property"
      end

      bands = (first_time_buyer && price <= FIRST_TIME_BUYER_MAX_PRICE) ? FIRST_TIME_BUYER : STANDARD
      surcharge = 0
      if price >= SURCHARGE_MIN_PRICE
        surcharge += ADDITIONAL_PROPERTY_SURCHARGE if additional_property
        surcharge += NON_RESIDENT_SURCHARGE if non_resident
      end
      surcharge.zero? ? bands : bands.map { |band| band.with_surcharge(surcharge) }
    end
  end
end
