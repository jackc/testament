require 'thor'
require 'thor/group'
require 'testament/project'
require 'testament/report'

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
    project = Testament::Project.load
    record = project.record command_words
    exit record[:exit_status]
  end

  desc "log", "print logs"
  def log
    project = Testament::Project.load
    puts project.log
  end

  desc "report [REPORT_NAME]", "run REPORT_NAME"
  long_desc <<-END_TXT
Reports are stored in .testament/report. You can alter or create new reports
there.

Available reports: #{Testament::Report::Loader.new.report_names.join(' ')}
END_TXT
  def report(name='default')
    require 'terminal-table'
    project = Testament::Project.load
    report = project.report name
    table = Terminal::Table.new :headings => report.headers, :rows => report.rows
    puts table
  end
end
