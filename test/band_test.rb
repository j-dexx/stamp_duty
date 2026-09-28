require "test_helper"

class BandTest < Minitest::Test
  def test_description_when_in_lowest_band
    band = StampDuty::Band.new(lower_bound: 0, upper_bound: 125_000, percentage_rate: 0)

    assert_equal "Up to £125,000", band.description
  end

  def test_description_when_in_highest_band
    band = StampDuty::Band.new(lower_bound: 1_500_000, upper_bound: nil, percentage_rate: 12)

    assert_equal "Above £1,500,000", band.description
  end

  def test_description_when_in_middle_band
    band = StampDuty::Band.new(lower_bound: 250_000, upper_bound: 925_000, percentage_rate: 5)

    assert_equal "£250,001 to £925,000", band.description
  end

  def test_decimal_percentage_rate
    band = StampDuty::Band.new(lower_bound: 0, upper_bound: 0, percentage_rate: 5)

    assert_equal BigDecimal("0.05"), band.decimal_percentage_rate
  end

  def test_taxable_amount
    band = StampDuty::Band.new(lower_bound: 125_000, upper_bound: 250_000, percentage_rate: 2)

    assert_equal 0, band.taxable_amount(100_000)
    assert_equal 25_000, band.taxable_amount(150_000)
    assert_equal 125_000, band.taxable_amount(1_000_000)
  end

  def test_taxable_amount_without_upper_bound
    band = StampDuty::Band.new(lower_bound: 1_500_000, upper_bound: nil, percentage_rate: 12)

    assert_equal 100_000, band.taxable_amount(1_600_000)
  end

  def test_with_surcharge
    band = StampDuty::Band.new(lower_bound: 0, upper_bound: 125_000, percentage_rate: 2)

    assert_equal 7, band.with_surcharge(5).percentage_rate
    assert_equal 2, band.percentage_rate
  end

  def test_is_frozen
    assert_predicate StampDuty::Rates::STANDARD.first, :frozen?
  end
end
