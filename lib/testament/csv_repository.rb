require 'csv'

module Testament
  class CSVRepository
    attr_reader :file_name

    def initialize(file_name)
      @file_name = file_name
    end

    def store(command, start_time, end_time)
      ensure_file_exists

      CSV.open(file_name, 'ab') do |csv|
        csv << [command, start_time, end_time]
      end
    end

    private
      def ensure_file_exists
        return if File.exist?(file_name)
        CSV.open(file_name, 'wb') do |csv|
          csv << %w[command start_time end_time]
        end
      end
  end
end
