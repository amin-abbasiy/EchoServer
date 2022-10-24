require 'rails_helper'

RSpec.describe ::User, type: :model do
  context "Successful" do
    let(:user) { FactoryBot.create(:user) }
    let(:endpoint_1) { FactoryBot.create(:endpoint, user: user)  }
    let(:endpoint_2) { FactoryBot.create(:endpoint, user: user, path: "/new")  }
    it "Create first user" do
      user
      expect(::User.count).to eq(1)
    end

    it "Create first user and endpoints" do
      expect(user.reload.endpoints).to eq([endpoint_1, endpoint_2])
    end
  end

  after(:all) { ::User.destroy_all }
end
