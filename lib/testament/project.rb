require 'yaml'
require 'erb'
require 'testament/database'

module Testament
  class Project
    attr_reader :name, :user, :version

    def initialize(arguments)
      @database = Database.new arguments.fetch('database')
      @name = arguments.fetch('project')
      @user = arguments.fetch('user')
      @version = arguments.fetch('version')
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
        user: user,
        version: version
    end

    def log
      database.db[:executions].order(:start_time).all
    end

    def stats
      rows = database.db[:executions]
        .group_and_count(:project, :command)
        .select_append{(avg(elapsed_milliseconds) / 1000.0).as('average_time')}
        .select_append{(sum(elapsed_milliseconds) / 1000.0).as('total_time')}
        .all.map do |h|
        [h[:project], h[:command], h[:count], h[:average_time], h[:total_time]]
      end
    end

    def self.load
      config_path = ".testament/config.yml"
      config = YAML.load(ERB.new(File.read(config_path)).result)
      new config
    end

    private

    attr_reader :database
  end
end