require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/time/calculations'

require 'testament/report/base'

module Testament
  module Report
    def self.find(name)
      Loader.new.load
      "Testament::Report::#{name.camelize}".constantize
    end

    class Loader
      def load
        report_paths.each do |report_path|
          ::Kernel.load report_path
        end 
      end

      def report_names
        report_paths.map do |report_path|
          report_path[/\w+(?=\.rb$)/]
        end
      end

      private
        def report_paths
          Dir.glob('.testament/report/*.rb')
        end
    end
  end
end