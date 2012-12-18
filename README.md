# Testament

Testament is a tool to track the cost of running tests.

## Installation

    $ gem install testament

## Usage

To setup testament with your project run testament init on your project directory.

    $ testament init .

This will create a .testament directory with the project config and the SQLite database that will store the test run information.  

To track the time it takes to run your specs, run them like this every time:

    $ testament record rspec spec

If you have your default rake task set to run your whole test suite, then you can do this:

    $ testament record rake

You may want to create an alias to rake and rspec to run it with testament track automatically.

## Reports

To view the default report, run the following in your project folder:

    $ testament report

This will yield output like this:

    +-----------+---------+-------+--------------+------------+
    | Project   | Command | Count | Average time | Total time |
    +-----------+---------+-------+--------------+------------+
    | testament | rspec   | 4     | 6.03675      | 24.147     |
    +-----------+---------+-------+--------------+------------+

To see a report from just today run the following:

    $ testament report today

The report definitions are stored in .testament/report. You can edit the existing reports or create new ones.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
