# Quake Log Parser

A simple Quake log parser, written in Ruby.

## Validation

The gem can be validate using the unit tests.

In order to run them:

```sh

$ bundle install

$ rspec

```

This will show the tests status.

Also, a _coverage/_ directory is created with code coverage report.

## Installation

Build the gem and install:

```sh

$ gem build quake-log-parser.gemspec

$ gem install quake-log-parser-1.0.0.gem

```

## Usage

All commands below can be run inside IRB:

```ruby

require 'quake'

# Create a new Quake object
quake = Quake.new

# Parse a given Quake log file
quake.parse("{Path to log file}")

# All games read from log file are
# available on _games_ variable
quake.games

# To show a game statistics, just call
# _to_hash_ to game object
random_game = quake.games.sample
random_game.to_hash

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
