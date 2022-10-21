require 'rails_helper'

RSpec.describe AuthToken, type: :model do
  context "Successful Create" do
    subject { FactoryBot.create(:auth_token) }

    it "Create first user" do
      subject
      expect(User.count).to eq(1)
    end

    it "Create must increment count by 2" do
      subject
      expect(User.count).to eq(2)
    end
  end
end
