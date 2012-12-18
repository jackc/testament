require 'active_support/core_ext/string/inflections'

module Testament
  module Report
    class Default
      attr_reader :database

      def initialize(database)
        @database = database
      end

      def headers
        @headers ||= dataset.columns.map(&:to_s).map(&:humanize)
      end

      def rows
        @rows ||= result_set.map(&:values)
      end

      def result_set
        @result_set ||= dataset.all
      end

      def dataset
        database[:executions]
          .group_and_count(:project, :command)
          .select_append{(avg(elapsed_milliseconds) / 1000.0).as('average_time')}
          .select_append{(sum(elapsed_milliseconds) / 1000.0).as('total_time')}
      end
    end
  end
end