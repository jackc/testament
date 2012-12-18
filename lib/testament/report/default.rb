module Testament
  module Report
    class Default < Base
      def dataset
        database[:executions]
          .group_and_count(:project, :command)
          .select_append{(avg(elapsed_milliseconds) / 1000.0).as('average_time')}
          .select_append{(sum(elapsed_milliseconds) / 1000.0).as('total_time')}
      end
    end
  end
end