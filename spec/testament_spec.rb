require 'rspec'
require 'pry'
require 'fileutils'
require 'securerandom'

RSpec.configure do |config|
  def testament(args="")
    lib = File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
    bin = File.expand_path(File.join(File.dirname(__FILE__), '..', 'bin', 'testament'))
    `cd #{directory}; ruby -I #{lib} #{bin} #{args}`
  end
end

describe 'testament' do
  let(:directory) { File.expand_path(File.join(File.dirname(__FILE__), 'tmp', SecureRandom.hex)) }

  before do
    FileUtils.mkdir_p directory
  end

  after do
    FileUtils.rm_rf directory
  end

  context 'init' do
    it 'creates a .testament directory in path argument' do
      testament "init #{directory}"
      expect(File.directory?( File.join(directory, '.testament') )).to be_true
    end
  end

  context 'record' do
    before do
      testament "init #{directory}"
    end

    it 'executes a single word argument' do
      result = testament 'record pwd'
      expect(`pwd`.chomp).to eq(FileUtils.pwd)
    end

    it 'executes a multiple word argument' do
      result = testament 'record echo foo'
      expect(result).to eq("foo\n")
    end

    it 'records the execution of the command' do
      testament 'record echo foo'
      output = testament 'log'
      expect(output).to match(/echo foo/)
    end

    it 'returns the return code of the executed commnd' do
      testament "record ruby -e 'exit 1'"
      expect($?.exitstatus).to eq(1)
    end
  end

  context 'log' do
    before do
      testament "init #{directory}"
      testament('record echo foo')
    end

    it 'outputs the previously logged data' do
      output = testament 'log'
      expect(output).to match(/echo foo/)
    end
  end

  context 'report' do
    before do
      testament "init #{directory}"
      testament('record echo foo')
    end

    it 'runs default report when no name given' do
      actual = testament 'report'
      expect(actual).to match(/Command/)
    end

    it 'runs report by name' do
      actual = testament 'report today'
      expect(actual).to match(/echo foo/)
    end
  end
end
