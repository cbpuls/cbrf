# Cbrf

()[https://www.cbr.ru/secinfo/secinfo.asmx]
[https://www.cbr.ru/CreditInfoWebServ/CreditOrgInfo.asmx]
[https://www.cbr.ru/DailyInfoWebServ/DailyInfo.asmx]

TODO: Delete this and the text below, and describe your gem

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/cbrf`. To experiment with that code, run `bin/console` for an interactive prompt.

## Documentation

## Installation

TODO: Replace `UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG` with your gem name right after releasing it to RubyGems.org. Please do not do it earlier due to security reasons. Alternatively, replace this section with instructions to install your gem from git if you don't plan to release to RubyGems.org.

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG
```

## Usage

### Credit

Описание документации [ссылке](https://www.cbr.ru/CreditInfoWebServ/CreditOrgInfo.asmx)
Для простоты весь последующий код будет использовать включение `include Cbrf::Credit`
sberbank_bic = "044525225"
sberbank_internal_code = 350_000_004
sberbank_registry_no = 1481

id = Id.new(sberbank_bic)
id = Id.new(sberbank_internal_code)
id = Id.new(sberbank_registry_no)
id = Id.new(internal_code: sberbank_internal_code, registry_no: sberbank_registry_no, bic: sberbank_bic)

id.internal_code # => 350_000_004
id.registry_no # => 1481
ids = Id.all # Return all organizations with BIC

include Cbrf::Credit

Organization.find("044525225") # Return full information by Sberbank
Organization.find("044525225", 1000) # Return full info about sberbank and vtb

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/[USERNAME]/cbrf>. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/cbrf/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Cbrf project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/cbrf/blob/master/CODE_OF_CONDUCT.md).
