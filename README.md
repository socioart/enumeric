# Enumeric

Enumeric makes you can define "enum" like in other languages on Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'enumeric'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install enumeric

## Usage

```ruby
module Foo
  # The following code defines constants: Colors, Colors::RED, Colors::GREEN, Colors::BLUE.
  Colors = Enumeric.define(
    RED: 0,
    GREEN: 1,
    BLUE: 2,
  )

  def hex(color)
    # You can use it in pattern matching
    case color
    in Colors::RED
      "#ff0000"
    in Colors::GREEN
      "#00ff00"
    in Colors::BLUE
      "#0000ff"
    end
  end
end

Foo::Colors.names #=> [:RED, :GREEN, :BLUE]
Foo::Colors.values #=> [0, 1, 2]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/labocho/enumeric.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
