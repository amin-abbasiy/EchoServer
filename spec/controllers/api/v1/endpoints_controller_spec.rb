require_relative '../../../rails_helper'

RSpec.describe ::Api::V1::EndpointsController, type: :controller do
  describe "POST" do
    let(:payload) {
      {
        data: {
          type: "endpoints",
          attributes: {
            verb: "GET",
            path: "/greeting",
            response: {
              code: 201,
              headers: { test: "value" },
              body: "\"{ \"message\": \"Hello, world\" }\""
            }
          }
        }
      }
    }
    context "successful #POST" do
      before {
        current_user
      }
      let(:body_response) {
        {
          data: {
            id: @current_user.endpoints.last.id.to_s,
            type: "endpoints",
            attributes: {
              verb: "GET",
              path: "/greeting",
              response: {
                  code: "201",
                  headers: { test: "value" },
                  body: "\"{ \"message\": \"Hello, world\" }\""
              }
            }
          }
        }
      }
      it "check for response json" do
        post :create, params: payload, format: :json
        expect(response.body).to eq(body_response.to_json)
      end

      it "check for response json structure" do
        post :create, params: payload, format: :json
        expect(response.body).to include_json(body_response)
      end

      it "check for response status" do
        post :create, params: payload, format: :json
        expect(response).to have_http_status(201)
      end

      it "check for response endpoint type" do
        post :create, params: payload, format: :json
        expect(response.body).to include_json(data: { type: "endpoints" })
      end

      it "check for response verb" do
        post :create, params: payload, format: :json
        expect(response.body).to include_json({ data: { attributes: { verb: "GET" }}})
      end

      it "check for path correctness" do
        post :create, params: payload, format: :json
        expect(response.body).to include_json({ data: { attributes: { path: "/greeting" }}})
      end

      it "check response content type" do
        post :create, params: payload, format: :json
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
    describe "Error cases in #POST" do
      let(:payload_data) {
        {
          "invalid": {
            "type": "endpoints",
            "attributes": {
              "verb": "GET",
              "path": "/greeting",
              "response": {
                "code": 200,
                "headers": {},
                "body": "\"{ \"message\": \"Hello, world\" }\""
              }
            }
          }
        }
      }

      let(:invalid_attribute) {
        {
          "data": {
            "type": "endpoints",
            "attributed": {
              "verb": "GET",
              "path": "/greeting",
              "response": {
                "code": 200,
                "headers": {},
                "body": "\"{ \"message\": \"Hello, world\" }\""
              }
            }
          }
        }
      }

      let(:invalid_response_payload) {
        {
          "data": {
            "type": "endpoints",
            "attributes": {
              "verb": "GET",
              "path": "/greeting",
              "response_21": {
                "code": 200,
                "headers": {},
                "body": "\"{ \"message\": \"Hello, world\" }\""
              }
            }
          }
        }
      }

      let(:invalid_data_error) {
        {
          "errors": [
            {
              "title": "EchoError",
              "status": 400,
              "code": "Response payload is invalid",
              "message": [
                "Response payload is invalid"
              ]
            }
          ]
        }
      }

      let(:invalid_attribute_error) {
        {
          "errors": [
            {
              "title": "EchoError",
              "status": 400,
              "code": "Data Payload",
              "message": [
                "Data Payload"
              ]
            }
          ]
        }
      }

      let(:invalid_response_error) {
        {
          "errors": [
            {
              "title": "EchoError",
              "status": 400,
              "code": "Attributes payload is invalid",
              "message": [
                "Attributes payload is invalid"
              ]
            }
          ]
        }
      }

      context "User Logged in" do
        before {
          current_user
        }

        it "raise data validation error" do
          post :create, params: payload_data, format: :json
          expect(response.body).to include_json(invalid_data_error)
        end

        it "check http status for invalid data" do
          post :create, params: payload_data, format: :json
          expect(response).to have_http_status(400)
        end

        it "raise data.attribute validation error" do
          post :create, params: invalid_attribute, format: :json
          expect(response.body).to include_json(invalid_attribute_error)
        end

        it "check http status for invalid data values" do
          post :create, params: invalid_attribute, format: :json
          expect(response).to have_http_status(400)
        end

        it "raise data.response validation error" do
          post :create, params: invalid_response_payload, format: :json
          expect(response.body).to include_json(invalid_response_error)
        end

        it "raise data.response validation error status" do
          post :create, params: invalid_response_payload, format: :json
          expect(response).to have_http_status(400)
        end

        it "raise error for empty payload" do
          post :create, params: { }, format: :json
          expect(response.body).to include_json(invalid_data_error)
        end

        it "raise data.response validation error status" do
          post :create, params: { }, format: :json
          expect(response).to have_http_status(400)
        end
      end

      context "User not Logged in" do
        let(:expected_error) {
          {
            "errors": [
              {
                "title": "Unauthorized",
                "status": 401,
                "code": "unauthorized",
                "message": [
                  "Nil JSON web token"
                ]
              }
            ]
          }
        }
        it "check user does not logged_in" do
          post :create, params: payload, format: :json
          expect(response.body).to include_json(expected_error)
        end
      end
    end
  end
  describe "Index" do
    context "Successful" do
      let(:user) { FactoryBot.create(:user_with_token) }
      let(:endpoint_get) { FactoryBot.create(:endpoint_with_get, user: user) }
      let(:endpoint_post) { FactoryBot.create(:endpoint_with_post, user: user) }

      before do
        sign_in(user)
        endpoint_get
        endpoint_post
      end

      let(:expected_response) {
        {
          "data": [
            {
              "id": endpoint_get.id.to_s,
              "type": "endpoints",
              "attributes": {
                "verb": "GET",
                "path": "/greet",
                "response": {
                  "code": "200",
                  "headers": {},
                  "body": "\"{ \"message\": \"Hello, world\" }\""
                }
              }
            },
            {
              "id": endpoint_post.id.to_s,
              "type": "endpoints",
              "attributes": {
                "verb": "POST",
                "path": "/greet_post",
                "response": {
                  "code": "200",
                  "headers": {},
                  "body": "\"{ \"message\": \"Hello, world\" }\""
                }
              }
            }
          ]
        }
      }
      it "load list" do
        get :index
        expect(response.body).to include_json(expected_response)
      end

      it "count list" do
        get :index
        expect(JSON.parse(response.body)["data"].count).to eq(2)
      end

      it "status code" do
        get :index
        expect(response).to have_http_status(200)
      end

      after do
        user.endpoints.destroy_all
      end
    end
    context "Fail" do
      let(:expired_auth_token) { FactoryBot.create(:expired_auth_token) }

      let(:unauthorized_response) {
        {
          "errors": [
            {
              "title": "Unauthorized",
              "status": 401,
              "code": "unauthorized",
              "message": [
                "Signature verification failed"
              ]
            }
          ]
        }
      }

      let(:no_token_provided) {
        {
          "errors": [
            {
              "title": "Unauthorized",
              "status": 401,
              "code": "unauthorized",
              "message": [
                "Nil JSON web token"
              ]
            }
          ]
        }
      }

      let(:expired_signature) {
        {
          "errors": [
            {
              "title": "Unauthorized",
              "status": 401,
              "code": "unauthorized",
              "message": [
                "Signature has expired"
              ]
            }
          ]
        }
      }
      it "unauthorized request" do
        get :index
        expect(response.body).to include_json(no_token_provided)
      end

      it "status code" do
        get :index
        expect(response).to have_http_status(401)
      end

      it "invalid token" do
        set_invalid_token
        get :index
        expect(response.body).to include_json(unauthorized_response)
      end

      it "expired token" do
        sign_in(expired_auth_token.user)
        get :index
        expect(response.body).to include_json(expired_signature)
      end
    end
  end
end
