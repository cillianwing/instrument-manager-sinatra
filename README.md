# Instrument Manager

This Sinatra-based web app helps a user manage their musical instruments and accessories. The user is able to manage their instruments/accessories by creating new ones, editing condition/status/etc. of existing ones, and deleting ones from their inventory. Additionally, the user is able to manage instruments/accessories that are being repaired. The repair feature allows the user to monitor the status, cost, duration, and more.

## Usage

Please type the below, navigate to the browser, and begin using the instrument manager app.

    $ bundle install
    $ rake db:migrate
    $ shotgun

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cillianwing/instrument-manager-sinatra. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the InstrumentManager project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/cillianwing/instrument-manager-sinatra/blob/master/CODE_OF_CONDUCT.md).
