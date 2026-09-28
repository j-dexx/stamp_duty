require "test_helper"

class ResidentialCalculatorTest < Minitest::Test

  def test_purchase_price_is_decimal
    calc = StampDuty::ResidentialCalculator.new(125000, nil)

    assert_instance_of BigDecimal, calc.purchase_price
  end

  def test_stamp_duty_when_price_is_125k
    calc = StampDuty.for(125000)

    assert_equal 0, calc.stamp_duty
  end

  def test_stamp_duty_when_price_is_250k
    calc = StampDuty.for(250000)

    calc.calculate

    assert_equal 2500, calc.stamp_duty
  end

  def test_stamp_duty_when_price_is_925k
    calc = StampDuty.for(925000)

    calc.calculate

    assert_equal 36250, calc.stamp_duty
  end

  def test_stamp_duty_when_price_is_1500k
    calc = StampDuty.for(1500000)

    calc.calculate

    assert_equal 93750, calc.stamp_duty
  end

  def test_stamp_duty_when_price_is_1600k
    calc = StampDuty.for(1600000)

    calc.calculate

    assert_equal 105750, calc.stamp_duty
  end

  def test_stamp_duty_without_calling_calculate
    assert_equal 3750, StampDuty.for(275000).stamp_duty
  end

  def test_calculate_is_idempotent
    calc = StampDuty.for(275000)

    calc.calculate
    calc.calculate

    assert_equal 3750, calc.stamp_duty
    assert_equal 3, calc.band_amounts.size
  end

  def test_calculate_returns_self
    calc = StampDuty.for(275000)

    assert_same calc, calc.calculate
  end

  def test_band_amounts_are_ordered_lowest_band_first
    amounts = StampDuty.for(275000).band_amounts.map { |ba| [ba.percentage_rate, ba.amount] }

    assert_equal [[0, 0], [2, 2500], [5, 1250]], amounts
  end

  def test_stamp_duty_is_rounded_down_to_the_pound
    calc = StampDuty.for(250000.1)

    assert_equal 2500, calc.stamp_duty
    assert_instance_of BigDecimal, calc.stamp_duty
  end

  def test_stamp_duty_when_price_is_zero
    assert_equal 0, StampDuty.for(0).stamp_duty
  end

  def test_accepts_bigdecimal_and_rational_prices
    assert_equal 3750, StampDuty.for(BigDecimal("275000")).stamp_duty
    assert_equal 3750, StampDuty.for(Rational(275000)).stamp_duty
  end

  def test_rejects_invalid_prices
    ["275000", "abc", nil, -1, Float::NAN, Float::INFINITY, BigDecimal("NaN"), Complex(1, 1)].each do |price|
      assert_raises(ArgumentError, "expected #{price.inspect} to be rejected") { StampDuty.for(price) }
    end
  end
end
