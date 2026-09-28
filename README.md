# StampDuty

StampDuty is a Stamp Duty Land Tax (SDLT) calculator for residential property
in England and Northern Ireland, using the rates in force from 1 April 2025.
It supports first-time buyer relief, the higher rates for additional
properties and the non-UK resident surcharge. Scotland (LBTT) and Wales (LTT)
are not covered.

Requires Ruby 3.3 or later.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'stamp_duty'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stamp_duty

## Usage

```ruby
calc = StampDuty.for(275_000)

# a BigDecimal, rounded down to the whole pound as HMRC does
calc.stamp_duty.to_s("F") # => "3750.0"
```

Pass options for reliefs and surcharges:

```ruby
StampDuty.for(400_000, first_time_buyer: true)    # 0% to £300k, 5% to £500k
StampDuty.for(300_000, additional_property: true) # +5% on every band
StampDuty.for(300_000, non_resident: true)        # +2% on every band
```

- First-time buyer relief does not apply above £500,000; standard rates are used instead.
- Surcharges only apply to purchases of £40,000 or more.
- `first_time_buyer` and `additional_property` cannot both be true.

The price must be a non-negative, finite number (Integer, BigDecimal, Rational
or Float) and the options must be `true` or `false`. Anything else raises
`ArgumentError`.

The tax due in each band is available too:

```ruby
calc.band_amounts.each do |ba|
  puts ba.description
  puts ba.amount.to_s("F")
  puts ba.percentage_rate
end
```

```
Up to £125,000
0.0
0
£125,001 to £250,000
2500.0
2
£250,001 to £925,000
1250.0
5
```

Results are immutable. `calc.to_h` returns a plain hash for serialising.
`calc.calculate` is kept for compatibility with 0.1.0 and returns the same
result.

Type signatures are included in `sig/`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

To release a new version, update the version number in `version.rb` and the
CHANGELOG, merge to master, then run the **Release** workflow from the Actions
tab. It publishes to [rubygems.org](https://rubygems.org) using trusted
publishing, so no API key is stored anywhere.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/j-dexx/stamp_duty.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

