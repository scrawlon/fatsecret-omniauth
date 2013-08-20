require 'spec_helper'

describe OmniAuth::Strategies::Fatsecret do
  subject do
    OmniAuth::Strategies::Fatsecret.new({})
  end

  context 'strategy client options' do
    it 'should have correct name' do
      expect(subject.options.name).to eq('fatsecret')
    end

    it 'should have correct site' do
      expect(subject.options.client_options.site).to eq('http://www.fatsecret.com')
    end

    it 'should have correct scheme' do
      expect(subject.options.client_options.scheme).to eq(:query_string)
    end

    it 'should have correct http_method' do
      expect(subject.options.client_options.http_method).to eq(:get)
    end
  end
end


