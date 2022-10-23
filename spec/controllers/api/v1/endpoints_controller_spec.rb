require_relative '../../../rails_helper'

RSpec.describe ::Api::V1::EndpointsController, type: :controller do
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
