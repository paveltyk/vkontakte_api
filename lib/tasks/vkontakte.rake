require 'yaml'

namespace :vkontakte do
  desc "Creates default config YAML file under config directory."
  task :create_yml do
    yml = Hash.new
    yml[:development] = {:api_secret => 'secret', :test_mode => true}
    yml[:production] = {:api_secret => 'secret', :test_mode => false}
    File.open("#{RAILS_ROOT}/config/vkontakte.yml", 'w') do |out|
      YAML.dump yml, out
    end
  end
end
