require 'yaml'
require 'testament/database'

module Testament
  class Project
    attr_reader :name

    def initialize(arguments)
      @database = Database.new arguments.fetch('database')
      @name = arguments.fetch('project')
    end

    def record(command)
      start_time = Time.now
      system command
      end_time = Time.now
      elapsed_milliseconds = ((end_time - start_time) * 1000).round

      database.record project: name,
        command: command,
        start_time: start_time,
        elapsed_milliseconds: elapsed_milliseconds,
        user: 'foo',
        version: 'foo'
    end

    def log
      database.db[:executions].order(:start_time).all
    end

    def stats
      rows = database.db["select command, count(*) as execution_count, avg(elapsed_milliseconds) / 1000.0 as average_time, sum(elapsed_milliseconds) / 1000.0 as total_time from executions group by command"].all.map do |h|
        [h[:command], h[:execution_count], h[:average_time], h[:total_time]]
      end
    end

    def self.load
      config_path = ".testament/config.yml"
      config = YAML.load(File.read(config_path))
      new config
    end

    private

    attr_reader :database
  end
end