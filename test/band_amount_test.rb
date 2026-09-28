require "test_helper"

class BandAmountTest < Minitest::Test
  def test_amount
    band = StampDuty::Band.new(lower_bound: 100, upper_bound: 200, percentage_rate: 5)

    band_amount = StampDuty::BandAmount.for(band, 300)

    assert_equal 100, band_amount.taxable_amount
    assert_equal 5, band_amount.amount
  end

  def test_to_h
    band = StampDuty::Band.new(lower_bound: 125_000, upper_bound: 250_000, percentage_rate: 2)

    assert_equal(
      {
        description: "£125,001 to £250,000",
        lower_bound: 125_000,
        upper_bound: 250_000,
        percentage_rate: 2,
        taxable_amount: 25_000,
        amount: 500
      },
      StampDuty::BandAmount.for(band, 150_000).to_h
    )
  end
end
