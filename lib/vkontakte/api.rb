module Vkontakte
  class API
    attr_accessor :api_id, :api_url, :viewer_id, :api_secret

    def initialize(params = {})
      options = params.symbolize_keys
      @api_id = options[:api_id]
      @api_url = options[:api_url]
      @api_secret = API_SECRET if self.class.const_defined?(:API_SECRET)
      @viewer_id = options[:viewer_id]
      self.test_mode = TEST_MODE if self.class.const_defined?(:TEST_MODE)
    end

    attr_reader :test_mode
    def test_mode=(mode)
      @test_mode = [1, true, 'true', 't'].include?(mode) ? 1 : 0
    end

    def signature(request)
      params_string = URI.decode(params_for(request).to_param).gsub(/&/i, '')
      Digest::MD5.hexdigest "#{@viewer_id}#{params_string}#{self.api_secret}"
    end

    def params_for(request)
      request.params.merge( { :api_id => @api_id, :test_mode => @test_mode})
    end

    def execute(request)
      params = params_for(request)
      uri = URI.parse(@api_url)
      uri.query = params.merge({ :sig => signature(request) }).to_param
      Hash.from_xml(Net::HTTP.get(uri)).symbolize_keys_recursive!
    end

    def method_missing_with_request (method, *args)
      if Vkontakte::API_METHODS.include?(method.to_s)
        execute Request.new(method, args[0] || {})
      else
        method_missing_without_request(method, args)
      end
    end
    alias_method_chain :method_missing, :request

  end
  
end