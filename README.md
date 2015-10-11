# Quake Log Parser

A simple Quake log parser, written in Ruby.

## Validation

The gem can be validate using the _unit tests_.

In order to run them:

```sh

$ bundle install # Install dependencies

$ rspec          # Run automated tests

$ rubocop lib/   # Check if gem code is following ruby code guidelines

```

Also, a _coverage/_ directory is created on project root with code coverage report.

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
# (you can find some log files used during tests under 'spec/data/')
quake.parse("{Path to log file}")

# All games read from log file are
# available on 'games' variable
quake.games

# To show a game statistics, just call
# 'to_hash' to game object
random_game = quake.games.sample
random_game.to_hash

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
