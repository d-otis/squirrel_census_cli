# SquirrelCensus

Using NYC Open Data API for the Central Park Squirrel Census of 2018. I created a CLI that utilizes collaborating objects created from the API's JSON, `Squirrel` and `Date`. Each squirrel sighting instantiates a new `Squirrel` instance and the same goes for the `Date` class. A `Squirrel` instance has a `Date` and a `Date` object has many `Squirrel` instances.

Squirrel API
https://data.cityofnewyork.us/Environment/2018-Central-Park-Squirrel-Census-Squirrel-Data/vfnx-vebw


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'squirrel_census'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install squirrel_census

## Usage

Run `bin/squirrel_census` and follow the prompts.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/d-otis/squirrel_census_cli.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
