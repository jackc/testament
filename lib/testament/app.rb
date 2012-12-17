require 'thor'
require 'thor/group'

class App < Thor
  include Thor::Actions

  source_root(File.join(File.dirname(__FILE__), "generators"))

  attr_accessor :app_name

  desc "init PATH", "initialize testament in directory PATH"
  def init(path)
    self.app_name = File.basename File.expand_path(path)
    self.destination_root = path
    directory ".testament", ".testament"

    require 'testament/database'
    database = Testament::Database.new adapter: :sqlite, database: "#{path}/.testament/db.sqlite"
    database.create_schema
  end

  desc "record COMMAND", "record and execute COMMAND"
  def record(*command_words)
    Testament.load_config
    require 'testament/database'
    database = Testament::Database.new CONFIG.fetch('database')

    command = command_words.join(' ')
    start_time = Time.now
    system command
    end_time = Time.now
    elapsed_milliseconds = ((end_time - start_time) * 1000).round

    database.record project: CONFIG.fetch('project'), command: command, start_time: start_time, elapsed_milliseconds: elapsed_milliseconds, user: 'foo', version: 'foo'
  end

  desc "log", "print logs"
  def log
    Testament.load_config
    require 'testament/database'
    database = Testament::Database.new CONFIG['database']
    
    puts database.db[:executions].order(:start_time).all
  end

  desc "stats", "print statistics"
  def stats
    require 'terminal-table'

    Testament.load_config
    require 'testament/database'
    database = Testament::Database.new CONFIG['database']

    rows = database.db["select command, count(*) as execution_count, avg(elapsed_milliseconds) / 1000.0 as average_time, sum(elapsed_milliseconds) / 1000.0 as total_time from executions group by command"].all.map do |h|
      [h[:command], h[:execution_count], h[:average_time], h[:total_time]]
    end

    table = Terminal::Table.new :headings => ['Command', '# Records', 'Avg. Time', 'Total Time'], :rows => rows  
    puts table
  end

end