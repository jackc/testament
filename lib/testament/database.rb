require 'sequel'

module Testament
  module Database
    def self.connect(options)
      db = Sequel.connect options
      ::Object.const_set(:DB, db)
    end

    def self.create_schema
      DB.create_table :executions do
        primary_key :id, type: Bignum
        String :project, null: false, index: true
        String :command, null: false, index: true
        Time :start_time, null: false, index: true
        Time :end_time, null: false
        String :user, index: true
        String :version, index: true
      end

      DB.create_table :tags do
        primary_key :id
        String :name, null: false, index: true
      end

      DB.create_join_table execution_id: :executions, tag_id: :tags
    end
  end

end