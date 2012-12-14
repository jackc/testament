require 'thor'
require 'thor/group'

require 'testament/csv_repository'

class App < Thor
  include Thor::Actions

  desc "record COMMAND", "record and execute COMMAND"
  def record(*command_words)
    command = command_words.join(' ')
    start_time = Time.now
    system command
    end_time = Time.now

    Testament::CSVRepository.new('testament.log').store command, start_time, end_time
  end

  desc "log", "print logs"
  def log
    puts Testament::CSVRepository.new('testament.log').log
  end

  desc "stats", "print statistics"
  def stats
    require 'terminal-table'

    rows = [
      ['rake', '13', '14.259 seconds', '8:14']
    ]

    table = Terminal::Table.new :headings => ['Command', '# Records', 'Avg. Time', 'Total Time'], :rows => rows  
    puts table
  end

end