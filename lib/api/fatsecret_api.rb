module Fatsecret
  class Api <  OmniAuth::Strategies::Fatsecret
    option :client_options, {
      :scheme       => :query_string,
      :http_method  => :get
    }
  
    def api_call auth_token, auth_secret, consumer_key, consumer_secret, params
      request = build_request(auth_token, auth_secret, consumer_key, consumer_secret)
      request_params = uri(params)
      request.get "http://platform.fatsecret.com/rest/server.api?#{ request_params }"
    end

    def uri params
      normalize = OAuth::Helper.normalize(params)
    end

    def build_request auth_token, auth_secret, consumer_key, consumer_secret
      fatsecret = Fatsecret::Api.new :fatsecret, consumer_key, consumer_secret
      access_token = OAuth::AccessToken.new fatsecret.consumer, auth_token, auth_secret
    end
  end
end