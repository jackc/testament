module Testament
  module Report
    class Today < Base
      def dataset
        time = Time.now

        database[:executions]
          .group_and_count(:project, :command)
          .select_append{(avg(elapsed_milliseconds) / 1000.0).as('average_time')}
          .select_append{(sum(elapsed_milliseconds) / 1000.0).as('total_time')}
          .where(start_time: (time.beginning_of_day..time.end_of_day))
      end
    end
  end
end