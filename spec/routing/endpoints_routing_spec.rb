require_relative '../rails_helper'

RSpec.describe "routes for Endpoints", :type => :routing do
  it "routes /endpoints to the Endpoints controller" do
    expect(get("api/v1/endpoints")).
      to route_to("api/v1/endpoints#index")
  end
end