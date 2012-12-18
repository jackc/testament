require 'thor'
require 'thor/group'
require 'testament/project'

class CLI < Thor
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
    command = command_words.join(' ')
    project = Testament::Project.load
    project.record command
  end

  desc "log", "print logs"
  def log
    project = Testament::Project.load
    puts project.log
  end

  desc "stats", "print statistics"
  def stats
    require 'terminal-table'
    project = Testament::Project.load
    report = project.stats
    table = Terminal::Table.new :headings => report.headers, :rows => report.rows
    puts table
  end

end