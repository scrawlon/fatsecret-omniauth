require 'spec_helper'

describe Fatsecret::Api do
  subject do
    Fatsecret::Api.new({})
  end

  context 'api client options' do
    consumer_key = "user_consumer_key"
    consumer_secret = "user_consumer_secret"

    it 'should have correct name' do
      expect(subject.options.name).to eq('api')
    end

    it 'should have correct scheme' do
      expect(subject.options.client_options.scheme).to eq(:query_string)
    end

    it 'should have correct http_method' do
      expect(subject.options.client_options.http_method).to eq(:get)
    end
  end

  context 'valid authenticated call' do
    consumer_key = "user_consumer_key"
    consumer_secret = "user_consumer_secret"
    params = { :method => 'foods.search', :search_expression => 'banana cream pie' }
    auth_token = 'user_token'
    auth_secret = 'user_secret'

    it 'should uri encode the params hash' do
      expect(subject.uri(params)).to eq('method=foods.search&search_expression=banana%20cream%20pie')
    end
    
    it 'should create an OAuth::AccessToken' do
      expect(subject.build_request(consumer_key, consumer_secret, auth_token, auth_secret).class).to eq(OAuth::AccessToken)
    end

    it 'should make successful api call ' do
      expect(subject.api_call(consumer_key, consumer_secret, params, auth_token, auth_secret).class).to eq(Net::HTTPOK)
    end
  end
end


