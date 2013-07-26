require 'omniauth-oauth'

module OmniAuth
  module Strategies
    class Fatsecret < OmniAuth::Strategies::OAuth
      option :client_options, {
        :site               => 'http://www.fatsecret.com',
        :scheme             => :query_string,
        :http_method        => :get
      }
    end
  end
end
