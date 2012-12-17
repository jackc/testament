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
        String :user
        String :version
      end

      db.create_table :tags do
        primary_key :id
        String :name, null: false, index: true
      end

      db.create_join_table execution_id: :executions, tag_id: :tags
    end

    def record(attributes)
      db[:executions].insert attributes
    end
  end

end