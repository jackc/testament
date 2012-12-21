require 'sequel'

module Testament
  class Database
    attr_reader :db

    def initialize(connection_parameters)
      @db = Sequel.connect connection_parameters
    end

    def create_schema
      db.create_table :executions do
        primary_key :id, type: Bignum
        String :project, null: false
        String :command, null: false
        Time :start_time, null: false
        Fixnum :elapsed_milliseconds, null: false
        Fixnum :exit_status, null: false
        String :user, null: false
        String :version, null: false
        String :category, null: false
      end
    end

    def record(attributes)
      db[:executions].insert attributes
    end
  end

end