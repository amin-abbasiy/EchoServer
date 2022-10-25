require 'rails_helper'

RSpec.describe "Authentications", type: :request do
  describe "GET /index" do
    let(:user) { FactoryBot.create(:user_with_token, email: "test@mail.com") }
    let(:payload) {
      {  "email" => "test@mail.com",  "password" => "passcodeAa" }
    }
    before { user }
    it "check invalid parameters" do
      post "/login", params: payload
      expect(response.code).to eq("200")
    end
  end
end
