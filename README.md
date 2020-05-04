# Enum::Transitions

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'enum-transitions', '~> 1.0.1
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install enum-transitions

## Usage

```ruby
class Model < ApplicationRecord
  include Enum::Transitions::DSL

  enum state: [:pending, :active, :finihed, :failed]

  transitions enum: :state do
    allow pending => active

    allow active => [finihed, failed] do
      after do
        # ...
      end
    end

    after_leaving pending do
      # ...
    end
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/adone/enum-transitions.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
