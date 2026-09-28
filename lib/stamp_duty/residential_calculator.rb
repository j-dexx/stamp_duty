module StampDuty
  class ResidentialCalculator

    attr_reader :purchase_price, :bands

    def initialize(purchase_price, bands)
      @purchase_price = StampDuty.normalize_price(purchase_price)
      @bands = bands
    end

    # Total tax, rounded down to the whole pound as HMRC does.
    def stamp_duty
      @stamp_duty ||= band_amounts.map(&:amount).reduce(BigDecimal(0), :+).round(0, BigDecimal::ROUND_FLOOR)
    end

    # Band amounts ordered lowest band first.
    def band_amounts
      @band_amounts ||= build_band_amounts
    end

    # Kept for backwards compatibility; results are computed lazily.
    def calculate
      band_amounts
      self
    end

    private

    def build_band_amounts
      price = purchase_price
      bands.sort_by { |band| -band.lower_bound }.map do |band|
        band_amount = StampDuty::BandAmount.new(price: price, band: band)
        price = band.lower_bound
        band_amount
      end.reverse
    end
  end
end
