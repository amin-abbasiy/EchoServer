RSpec.describe ::Api::V1::BaseController do
  describe "successful auth" do
    it "error check" do
      expect(not_found).to include({ error: 'not_found' })
    end
  end
end