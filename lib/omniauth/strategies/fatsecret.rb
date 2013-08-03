require 'omniauth-oauth'
require 'multi_json'

module OmniAuth
  module Strategies
    class Fatsecret < OmniAuth::Strategies::OAuth
      option :client_options, {
        :site               => 'http://www.fatsecret.com',
        :scheme             => :query_string,
        :http_method        => :get
      }

      info do
        {
          goal_weight_kg: raw_info['goal_weight_kg'],
          height_cm: raw_info['height_cm'],
          height_measure: raw_info['height_measure'],
          last_weight_comment: raw_info['last_weight_comment'],
          last_weight_date_int: raw_info['last_weight_date_int'],
          last_weight_kg: raw_info['last_weight_kg'],
          weight_measure: raw_info['weight_measure']
        }
      end

      def raw_info
        @raw_info ||= MultiJson.decode(access_token.get('http://platform.fatsecret.com/rest/server.api?method=profile.get&format=json').body)['profile']
      end
    end
  end
end
