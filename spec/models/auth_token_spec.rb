require 'rails_helper'

RSpec.describe AuthToken, type: :model do
  context "Successful Create" do
    subject { FactoryBot.create(:auth_token) }

    it "first user" do
      subject
      expect(::AuthToken.count).to eq(1)
    end

    after(:all) { User.destroy_all }
  end
end
