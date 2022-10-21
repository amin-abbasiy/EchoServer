require 'rails_helper'

RSpec.describe ::User, type: :model do
  context "Successful Create" do
    it "Create" do
      ::User.create
    end
  end
end
