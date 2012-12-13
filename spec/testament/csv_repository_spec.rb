require 'rspec'
require 'fileutils'
require 'testament/csv_repository'

describe Testament::CSVRepository do
  before do
    FileUtils.rm_f file_path
  end

  subject(:repository) { Testament::CSVRepository.new file_path }

  let(:file_path) do
    'spec/tmp/csv.log'
  end

  describe 'store' do
    let(:command) { 'foo' }
    let(:start_time) { Time.local(2012,1,1, 13,0,0) }
    let(:end_time) { Time.local(2012,1,1, 13,0,1) }

    def rows
      CSV.read file_path
    end

    context 'when file does not exist' do
      before do
        repository.store command, start_time, end_time
      end

      it 'creates the file' do
        expect(File.exist?(file_path)).to be_true
      end

      it 'writes the CSV header' do
        expect(rows.first).to eq(%w[command start_time end_time])
      end

      it 'writes the record to the file' do
        expect(rows.size).to eq(2)
        actual_command, actual_start_time, actual_end_time = rows.last
        actual_start_time = Time.parse(actual_start_time)
        actual_end_time = Time.parse(actual_end_time)
        expect(actual_command).to eq(command)
        expect(actual_start_time).to eq(start_time)
        expect(actual_end_time).to eq(end_time)
      end
    end

    context 'when the file already exists' do
      before do
        repository.store command, start_time, end_time
        repository.store command, start_time, end_time
      end

      it 'appends the record to the file' do
        expect(rows.size).to eq(3)
      end
    end
  end
end
