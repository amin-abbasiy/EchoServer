require 'rails_helper'

RSpec.describe "Endpoints", type: :request do
  describe "Mock" do
    before do
      current_user
    end
    let(:endpoint_mock_get) { FactoryBot.create(:endpoint_mock_get, user: current_user) }
    let(:endpoint_mock_post) { FactoryBot.create(:endpoint_mock_post, user: current_user) }
    let(:endpoint_mock_patch) { FactoryBot.create(:endpoint_mock_patch, user: current_user) }
    let(:endpoint_mock_put) { FactoryBot.create(:endpoint_mock_put, user: current_user) }
    let(:endpoint_mock_delete) { FactoryBot.create(:endpoint_mock_delete, user: current_user) }
    let(:endpoint_mock_head) { FactoryBot.create(:endpoint_mock_head, user: current_user) }
    let(:headers) {
      { "Authorization" => "Bearer #{current_user.auth_tokens.last.value}" }
    }
    let(:expected_response) {
      {
        "message": "Hello, world"
      }
    }
    context "Successful" do
      it "expected result get" do
        endpoint_mock_get
        get "/greeting", :headers => headers
        expect(response.body).to include(expected_response.to_json)
      end

      it "expected result post" do
        endpoint_mock_post
        post "/greeting", :headers => headers
        expect(response.body).to include(expected_response.to_json)
      end

      it "expected result patch" do
        endpoint_mock_patch
        patch "/greeting", :headers => headers
        expect(response.body).to include(expected_response.to_json)
      end

      it "expected result put" do
        endpoint_mock_put
        put "/greeting", :headers => headers
        expect(response.body).to include(expected_response.to_json)
      end

      it "expected result delete" do
        endpoint_mock_delete
        delete "/greeting", :headers => headers
        expect(response.body).to include(expected_response.to_json)
      end

      it "expected result HEAD" do
        endpoint_mock_head
        head "/greeting", :headers => headers
        expect(response.body).to eq("")
      end
    end
    describe "Fail" do
      let(:not_found) {
        {
          "errors": [
            {
              "title": "Record Not found",
              "status": 404,
              "code": "record_not_found",
              "message": [
                "Couldn't find Endpoint with [WHERE \"endpoints\".\"user_id\" = $1 AND \"endpoints\".\"verb\" = $2 AND \"endpoints\".\"path\" = $3]"
              ]
            }
          ]
        }
      }

      context "All verb invalid url" do
        it "invalid url" do
          [:post, :patch, :delete, :put, :get].each do |verb|
            public_send(verb, "/some_non_existence_url", :headers => headers)
            expect(response.body).to include_json(not_found)
          end
        end

        it "invalid url code" do
          [:post, :patch, :delete, :put, :get].each do |verb|
            public_send(verb, "/some_non_existence_url", :headers => headers)
            expect(response).to have_http_status(404)
          end
        end
      end

      context "GET" do
        before do
          endpoint_mock_get
        end
        it "invalid verb except get" do
          [:post, :patch, :delete, :put].each do |verb|
            public_send(verb, "/greeting", :headers => headers)
            expect(response.body).to include_json(not_found)
          end
        end

        it "invalid verb except get code" do
          [:post, :patch, :delete, :put].each do |verb|
            public_send(verb, "/greeting", :headers => headers)
            expect(response).to have_http_status(404)
          end
        end
      end

      context "POST" do
        before do
          endpoint_mock_post
        end
        it "invalid verb except post" do
          [:get, :patch, :delete, :put].each do |verb|
            public_send(verb, "/greeting", :headers => headers)
            expect(response.body).to include_json(not_found)
          end
        end

        it "invalid verb except post code" do
          [:get, :patch, :delete, :put].each do |verb|
            public_send(verb, "/greeting", :headers => headers)
            expect(response).to have_http_status(404)
          end
        end
      end

      context "PATCH" do
        before do
          endpoint_mock_patch
        end
        it "invalid verb except patch" do
          [:get, :post, :delete, :put].each do |verb|
            public_send(verb, "/greeting", :headers => headers)
            expect(response.body).to include_json(not_found)
          end
        end

        it "invalid verb except patch code" do
          [:get, :post, :delete, :put].each do |verb|
            public_send(verb, "/greeting", :headers => headers)
            expect(response).to have_http_status(404)
          end
        end
      end

      context "PUT" do
        before do
          endpoint_mock_put
        end
        it "invalid verb except put" do
          [:get, :post, :delete, :patch].each do |verb|
            public_send(verb, "/greeting", :headers => headers)
            expect(response.body).to include_json(not_found)
          end
        end

        it "invalid verb except patch code" do
          [:get, :post, :delete, :patch].each do |verb|
            public_send(verb, "/greeting", :headers => headers)
            expect(response).to have_http_status(404)
          end
        end
      end

      context "DELETE" do
        before do
          endpoint_mock_delete
        end
        it "invalid verb except patch" do
          [:get, :post, :patch, :put].each do |verb|
            public_send(verb, "/greeting", :headers => headers)
            expect(response.body).to include_json(not_found)
          end
        end

        it "invalid verb except patch code" do
          [:get, :post, :patch, :put].each do |verb|
            public_send(verb, "/greeting", :headers => headers)
            expect(response).to have_http_status(404)
          end
        end
      end
    end
  end
end
