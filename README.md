# Testament

Note: readme driven development is being used -- not everything below will work yet!

NOT READY FOR PRODUCTION USE

Testament is a tool to track the cost of running tests.

## Installation

    $ gem install testament

## Usage

To track the time it takes to run your specs, run them like this every time:

    $ testament record rspec spec/

If you have your default rake task set to run your whole test suite, then you can do this:

    $ testament record rake

You may want to create an alias to rake and rspec to run it with testament track automatically.

## Seeing Trends

To view some stats, run this:

    $ testament stats

in your project folder.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
