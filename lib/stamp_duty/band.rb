# frozen_string_literal: true

module StampDuty
  # A slice of the purchase price, from lower_bound up to upper_bound (nil for
  # no limit), taxed at percentage_rate.
  Band = Data.define(:lower_bound, :upper_bound, :percentage_rate) do
    def decimal_percentage_rate
      percentage_rate.to_d / 100
    end

    # The part of price that falls within this band.
    def taxable_amount(price)
      top = upper_bound.nil? ? price : [price, upper_bound].min
      [top - lower_bound, 0].max
    end

    def applies_to?(price)
      price > lower_bound
    end

    def with_surcharge(percentage_points)
      with(percentage_rate: percentage_rate + percentage_points)
    end

    def description
      return "Up to #{format_pounds(upper_bound)}" if lower_bound.zero?
      return "Above #{format_pounds(lower_bound)}" if upper_bound.nil?

      "#{format_pounds(lower_bound + 1)} to #{format_pounds(upper_bound)}"
    end

    private

    def format_pounds(amount)
      "£#{amount.to_i.to_s.reverse.scan(/\d{1,3}/).join(",").reverse}"
    end
  end
end
