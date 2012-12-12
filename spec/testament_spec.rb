require 'rspec'

RSpec.configure do |config|
  def testament(args="")
    lib = File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
    bin = File.expand_path(File.join(File.dirname(__FILE__), '..', 'bin', 'testament'))
    `ruby -I #{lib} #{bin} #{args}`
  end
end

describe 'testament' do
  context 'record' do
    it 'execute it\'s argument' do
      result = testament('record echo foo')
      expect(result).to eq("foo\n")
    end

    it 'records the execution of the command' do
      testament('record echo foo')
      last_line = `tail -n 1 testament.log`
      command, execution_time = last_line.split("\t")
      expect(command).to eq('echo foo')
      expect(execution_time).to match(/\d+\.\d+/)
    end
  end
end
