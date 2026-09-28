require "test_helper"

class BandAmountTest < Minitest::Test

  def test_amount
    band = StampDuty::Band.new(100, 200, 5)

    calc = StampDuty::BandAmount.new(price: 200, band: band)

    assert_equal 5, calc.amount
  end

end
