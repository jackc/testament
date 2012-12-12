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
  end
end
