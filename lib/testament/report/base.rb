module Testament
  module Report
    class Base
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
        raise NotImplementedError
      end
    end
  end
end