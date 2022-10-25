require_relative '../rails_helper'

RSpec.describe "routes for Endpoints", :type => :routing do
  it "routes /endpoints to the Endpoints controller" do
    expect(get("api/v1/endpoints")).
      to route_to("api/v1/endpoints#index")
  end
  it "routes /endpoints to the Endpoints controller" do
    expect(post("api/v1/endpoints")).
      to route_to("api/v1/endpoints#create")
  end
  it "routes /endpoints to the Endpoints controller" do
    expect(patch("api/v1/endpoints/1")).
      to route_to(controller: 'api/v1/endpoints',
                  action: 'update',
                  id: "1")
  end
  it "routes /endpoints to the Endpoints controller" do
    expect(delete("api/v1/endpoints/1")).
      to route_to(controller: 'api/v1/endpoints',
                  action: 'destroy',
                  id: "1")
  end
  it "routes /endpoints to the Endpoints controller" do
    expect(delete("greet")).
      to route_to(controller: 'api/v1/endpoints',
                  action: 'show',
                  path: "greet")
  end
  it "routes /endpoints to the Endpoints controller" do
    expect(delete("random")).
      to route_to(controller: 'api/v1/endpoints',
                  action: 'show',
                  path: "random")
  end
end
