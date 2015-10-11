# Quake Log Parser

A simple Quake log parser, written in Ruby.

## Installation

Build the gem and install:

    gem build quake-log-parser.gemspec

    gem install quake-log-parser-1.0.0.gem

## Usage

    require 'quake'

    quake = Quake.new # Create a new Quake object

    quake.parse("{Path to log file}") # Parse a Quake log file

    quake.games # Show all games

    quake.first.to_hash # Show the first game summary

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
