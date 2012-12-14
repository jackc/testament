require 'rspec'
require 'pry'
require 'time' # for Time.parse

RSpec.configure do |config|
  def testament(args="")
    lib = File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
    bin = File.expand_path(File.join(File.dirname(__FILE__), '..', 'bin', 'testament'))
    `ruby -I #{lib} #{bin} #{args}`
  end
end

describe 'testament' do
  context 'record' do
    it 'executes a single word argument' do
      result = testament('record pwd')
      expect(`pwd`.chomp).to eq(FileUtils.pwd)
    end

    it 'executes a multiple word argument' do
      result = testament('record echo foo')
      expect(result).to eq("foo\n")
    end

    it 'records the execution of the command' do
      testament('record echo foo')
      last_line = `tail -n 1 testament.log`
      command, start_time, end_time = last_line.split(",")
      expect(command).to eq('echo foo')

      start_time = Time.parse(start_time) rescue nil
      expect(start_time).to be
      end_time = Time.parse(end_time) rescue nil
      expect(end_time).to be
    end
  end
end
