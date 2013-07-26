require 'omniauth-oauth'

module OmniAuth
  module Strategies
    class Fatsecret < OmniAuth::Strategies::OAuth
      option :client_options, {
        :site               => 'http://www.fatsecret.com',
        :format             => 'json',
        :oauth_nonce        => Time.now.to_i.to_s,
        :oauth_timestamp    => Time.now.to_i,
        :scheme             => :query_string,
        :http_method        => :get
      }
    end
  end
end
