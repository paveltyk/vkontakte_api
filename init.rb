config = File.join RAILS_ROOT, 'config', 'vkontakte.yml'
if File.exists?(config)
  params = YAML.load_file(config)[RAILS_ENV.to_sym]
  unless params.blank?
    Vkontakte::API.const_set :API_SECRET, params[:api_secret]
    Vkontakte::API.const_set :TEST_MODE, params[:test_mode]
  end
end
# Extend Hash class with symbolize_keys_recursive! method.
unless Hash.public_method_defined? :symbolize_keys_recursive!
  class ::Hash
    def symbolize_keys_recursive!
      symbolize_keys!
      values.select { |v| v.is_a?(Hash) }.each { |h| h.symbolize_keys_recursive! }
      self
    end
  end
end
