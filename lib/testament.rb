require "testament/version"

gem 'sequel', '~> 3.42.0'
gem 'terminal-table', '~> 1.4.5'


module Testament
  def self.load_config
    require 'yaml'
    config_path = ".testament/config.yml"
    config = YAML.load(File.read(config_path))
    ::Object.const_set :CONFIG, config
  end
end
