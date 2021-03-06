# CandidSearch

### DISCLAIMER: Currently a work in-progress, and will not be usable until 0.2.0

Simple search using model scopes to create queries for ActiveRecord

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'candid_search'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install candid_search

## Usage

CandidSearch requires you to include the module in the Active Model class
```ruby
class User < ApplicationRecord

  include CandidSearch

...

```

Prepare named scopes to be used by CandidSearch in the Active Model class
```ruby
class User < AppplicationRecord

  include CandidSearch

  scope :with_id,   ->(val) { where(id: val) }
  scope :with_name, ->(val) { where(name: val) }

...

```


Call `search_with` method on your model class in your Action Controller,
and pass a hash with key (scope name) value (search value) pairs.
### Be sure to whitelist the parameters passed to the method
```ruby
class UsersController < ApplicationController

  def index
    @users = User.search_with(search_params)
  end

  def search_params
    {
      with_id: permitted_search_params[:user_id],
      with_name: permitted_search_params[:name],
    }
  end

  def permitted_search_params
    params.permit(:user_id, :name)
  end
end
```

You can use multiple search keys by creating named scopes containing `or`
```ruby
  scope :with_id,   ->(val) { where(id: val) }
  scope :with_name, ->(val) { where(name: val) }

  scope :with_id_or_name, ->(val) { with_id(val).or(with_name(val)) }
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/candid_search. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CandidSearch project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/candid_search/blob/master/CODE_OF_CONDUCT.md).
