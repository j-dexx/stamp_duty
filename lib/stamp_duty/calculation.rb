# frozen_string_literal: true

module StampDuty
  # The result of a stamp duty calculation. Band amounts are ordered lowest
  # band first; stamp_duty is rounded down to the whole pound, as HMRC does.
  Calculation = Data.define(:purchase_price, :band_amounts, :stamp_duty) do
    def self.build(purchase_price, bands)
      band_amounts = bands
        .select { |band| band.applies_to?(purchase_price) }
        .sort_by(&:lower_bound)
        .map { |band| BandAmount.for(band, purchase_price) }
        .freeze
      total = band_amounts.sum(BigDecimal(0), &:amount).round(0, BigDecimal::ROUND_FLOOR)

      new(purchase_price: purchase_price, band_amounts: band_amounts, stamp_duty: total)
    end

    # Kept for compatibility with 0.1.0; results are calculated up front.
    def calculate
      self
    end

    def to_h
      {
        purchase_price: purchase_price,
        stamp_duty: stamp_duty,
        band_amounts: band_amounts.map(&:to_h)
      }
    end
  end
end
