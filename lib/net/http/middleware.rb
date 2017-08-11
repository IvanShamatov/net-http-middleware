require 'net/http'
require 'net/http/middleware/version'
require 'net/http/middleware/chain'

module Net
  class HTTP
    class << self
      attr_accessor :middleware_chain
    end

    def self.configure_middleware(&block)
      @middleware_chain ||= Net::HTTP::Middleware::Chain.new(&block)
    end

    alias_method(:orig_request, :request) unless method_defined?(:orig_request)

    def request(req, body = nil, &block)
      Net::HTTP.middleware_chain.call(req, body = nil) do
        orig_request(req, body, &block)
      end
    end
  end
end
