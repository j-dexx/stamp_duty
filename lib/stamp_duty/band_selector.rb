module StampDuty
  class BandSelector
    BAND_DATA = [
      { lower_bound: 0, upper_bound: 125000, percentage_rate: 0 },
      { lower_bound: 125000, upper_bound: 250000, percentage_rate: 2 },
      { lower_bound: 250000, upper_bound: 925000, percentage_rate: 5 },
      { lower_bound: 925000, upper_bound: 1500000, percentage_rate: 10 },
      { lower_bound: 1500000, percentage_rate: 12 }
    ]

    attr_reader :price

    def initialize(price)
      @price = price
    end

    def bands
      sorted_band_data.map{ |band_data| build_band(band_data) }
    end

    private

    def build_band(band_data)
      StampDuty::Band.new(band_data[:lower_bound], band_data[:upper_bound], band_data[:percentage_rate])
    end

    def sorted_band_data
      band_data_for_price.sort_by { |band| -band[:lower_bound] }
    end

    def band_data_for_price
      BAND_DATA.select{ |band| price > band[:lower_bound] }
    end
  end
end
