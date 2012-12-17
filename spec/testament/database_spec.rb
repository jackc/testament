require 'spec_helper'

describe Testament::Database do
  subject(:database) { described_class.new adapter: :sqlite }

  describe 'create_schema' do
    before { database.create_schema }

    it 'creates executions table' do
      expect(database.db.tables).to include(:executions)
    end

    it 'creates tags table' do
      expect(database.db.tables).to include(:tags)
    end

    it 'creates executions_tags table' do
      expect(database.db.tables).to include(:executions_tags)
    end
  end

  describe 'record' do
    before { database.create_schema }

    it 'inserts row in executions table' do
      database.record project: 'testament',
        command: 'record',
        start_time: Time.now,
        elapsed_milliseconds: 42,
        user: 'jack',
        version: '12345678abcdef'

      expect(database.db[:executions].count).to eq(1)
    end
  end
end
