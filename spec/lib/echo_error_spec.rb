require 'rails_helper'

RSpec.describe EchoError do
  describe 'Echo Error' do
    let(:jwt_decode_error) { described_class.new(:jwt_decode_error) }
    let(:data_validation) { described_class.new(:data_validation) }
    let(:attribute_validation) { described_class.new(:attribute_validation) }
    let(:response_validation) { described_class.new(:response_validation) }
    let(:authentication) { described_class.new(:authentication) }
    let(:unknown_error) { described_class.new(:invalid_code) }

    it "unknown error" do
      expect(unknown_error.message).to eq('Unknown Error')
    end

    it "json error" do
      expect(jwt_decode_error.message).to eq('Jwt decode were failed')
    end

    it "data error" do
      expect(data_validation.message).to eq('Data Payload')
    end

    it "attributes error" do
      expect(attribute_validation.message).to eq('Attributes payload is invalid')
    end

    it "response error" do
      expect(response_validation.message).to eq('Response payload is invalid')
    end

    it "authentication error" do
      expect(authentication.message).to eq('Email or password is incorrect')
    end
  end
end