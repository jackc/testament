require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/time/calculations'

require 'testament/report/base'

module Testament
  module Report
    def self.find(name)
      Loader.new.call
      "Testament::Report::#{name.camelize}".constantize
    end

    class Loader
      def call
        report_paths.each do |report_path|
          load report_path
        end 
      end

      private
        def report_paths
          Dir.glob('.testament/report/*.rb')
        end
    end
  end
end