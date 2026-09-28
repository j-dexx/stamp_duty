require "test_helper"

# Expected figures from HMRC worked examples where available (marked), and
# otherwise worked by hand from the published rates.
# https://www.gov.uk/stamp-duty-land-tax/residential-property-rates
class ReferenceTest < Minitest::Test
  CASES = [
    # price, options, expected
    [295_000, {}, 4_750], # HMRC residential rates example
    [125_000, {}, 0],
    [125_001, {}, 0],
    [250_000, {}, 2_500],
    [925_000, {}, 36_250],
    [1_500_000, {}, 93_750],
    [1_600_000, {}, 105_750],

    [300_000, {first_time_buyer: true}, 0],
    [300_001, {first_time_buyer: true}, 0],
    [500_000, {first_time_buyer: true}, 10_000],
    [500_001, {first_time_buyer: true}, 15_000],

    [300_000, {additional_property: true}, 20_000], # HMRC higher rates example
    [39_999, {additional_property: true}, 0],
    [40_000, {additional_property: true}, 2_000],

    [700_000, {first_time_buyer: true, non_resident: true}, 39_000], # HMRC non-resident example
    [39_999, {non_resident: true}, 0],
    [40_000, {non_resident: true}, 800],
    [400_000, {first_time_buyer: true, non_resident: true}, 13_000],
    [300_000, {additional_property: true, non_resident: true}, 26_000]
  ].freeze

  CASES.each do |price, options, expected|
    name = [price, *options.select { |_, v| v }.keys].join("_")
    define_method(:"test_#{name}") do
      assert_equal expected, StampDuty.for(price, **options).stamp_duty
    end
  end
end
