module Vkontakte
  class Request
    attr_accessor :params
    def initialize(method, params = {})
      @params = params
      @params[:method] = method.to_s.gsub('_', '.')
    end
  end
end