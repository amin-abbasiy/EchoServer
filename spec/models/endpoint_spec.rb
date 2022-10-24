require 'rails_helper'

RSpec.describe ::Endpoint, type: :model do
  context "Endpoint" do
    let(:user) { FactoryBot.create(:user) }
    let(:endpoint) { FactoryBot.create(:endpoint, user: user)  }

    it "Create first endpoint" do
      endpoint
      expect(user.endpoints.count).to eq(1)
    end

    it "Create first user and an endpoint" do
      expect(user.reload.endpoints).to eq([endpoint])
    end

    it "create duplicate path endpoints" do
      endpoint
      expect { FactoryBot.create(:endpoint, user: user) }.to raise_error(ActiveRecord::RecordNotUnique)
    end

  end

  after(:all) { ::User.destroy_all }
end
