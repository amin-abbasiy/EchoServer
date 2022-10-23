require 'rails_helper'

RSpec.describe "Endpoints", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get '/api/v1/endpoints'
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/api/v1/endpoints/create"
    end
  end

  describe "GET /delete" do
    it "returns http success" do
      get "/api/v1/endpoints/delete"
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/api/v1/endpoints/update"
    end
  end

end
