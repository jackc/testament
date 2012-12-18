require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/time/calculations'

require 'testament/report/base'
require 'testament/report/default'
require 'testament/report/today'

module Testament
  module Report
    def self.find(name)
      "Testament::Report::#{name.camelize}".constantize
    end
  end
end