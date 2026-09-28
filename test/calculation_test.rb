require "test_helper"

class CalculationTest < Minitest::Test
  def test_purchase_price_is_decimal
    assert_instance_of BigDecimal, StampDuty.for(125_000).purchase_price
  end

  def test_calculate_returns_self
    calc = StampDuty.for(275_000)

    assert_same calc, calc.calculate
    assert_equal 3750, calc.calculate.calculate.stamp_duty
  end

  def test_band_amounts_are_ordered_lowest_band_first
    amounts = StampDuty.for(275_000).band_amounts.map { |ba| [ba.percentage_rate, ba.amount] }

    assert_equal [[0, 0], [2, 2500], [5, 1250]], amounts
  end

  def test_no_band_amounts_when_price_is_zero
    calc = StampDuty.for(0)

    assert_empty calc.band_amounts
    assert_equal 0, calc.stamp_duty
  end

  def test_stamp_duty_is_rounded_down_to_the_pound
    calc = StampDuty.for(250_000.1)

    assert_equal 2500, calc.stamp_duty
    assert_instance_of BigDecimal, calc.stamp_duty
  end

  def test_is_immutable
    calc = StampDuty.for(275_000)

    assert_predicate calc, :frozen?
    assert_predicate calc.band_amounts, :frozen?
  end

  def test_to_h
    hash = StampDuty.for(150_000).to_h

    assert_equal 150_000, hash[:purchase_price]
    assert_equal 500, hash[:stamp_duty]
    assert_equal ["Up to £125,000", "£125,001 to £250,000"], hash[:band_amounts].map { |ba| ba[:description] }
  end

  def test_accepts_bigdecimal_and_rational_prices
    assert_equal 3750, StampDuty.for(BigDecimal(275_000)).stamp_duty
    assert_equal 3750, StampDuty.for(Rational(275_000)).stamp_duty
  end

  def test_rejects_invalid_prices
    ["275000", "abc", nil, -1, Float::NAN, Float::INFINITY, BigDecimal("NaN"), Complex(1, 1)].each do |price|
      assert_raises(ArgumentError, "expected #{price.inspect} to be rejected") { StampDuty.for(price) }
    end
  end

  def test_rejects_non_boolean_flags
    assert_raises(ArgumentError) { StampDuty.for(275_000, first_time_buyer: "no") }
    assert_raises(ArgumentError) { StampDuty.for(275_000, additional_property: nil) }
    assert_raises(ArgumentError) { StampDuty.for(275_000, non_resident: 1) }
  end

  def test_first_time_buyer_cannot_buy_additional_property
    assert_raises(ArgumentError) do
      StampDuty.for(275_000, first_time_buyer: true, additional_property: true)
    end
  end
end
