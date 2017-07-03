# RubyVoluum

A Voluum API wrapper.

API Documentation: API documentation: https://developers.voluum.com/

Handles fetching reports, and campaigns, landers and offers manipulations.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby_voluum'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby_voluum

## Usage

```
client = RubyVoluum::Client.new(email: 'user@domain.com', password: 'yourpass')

# report
report = client.report(from: Date.today, to: Date.today + 1)

report.totals
# => {
#   "advertiserCost"=>0.0,
#   "ap"=>33.5,
#   "bids"=>0,
#   "clicks"=>459,
#   "conversions"=>4,
#   "cost"=>107.1316,
#   "cpv"=>0.06269,
#   "cr"=>0.87146,
#   "ctr"=>26.85781,
#   "cv"=>0.23406,
#   "epc"=>0.29194,
#   "epv"=>0.07841,
#   "errors"=>0,
#   "ictr"=>0.0,
#   "impressions"=>0,
#   "profit"=>26.8684,
#   "revenue"=>134.0,
#   "roi"=>25.07981,
#   "visits"=>1709,
#   "winRate"=>0.0
# }
report.rows #=> array of hashes
report.rows[0] #=> hash of campaign with indicators
```



TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/denker/ruby_voluum.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
