require_relative '../../../rails_helper'

RSpec.describe ::Api::V1::AuthenticationsController, type: :controller do
  describe "Sign in" do
    let(:user) { FactoryBot.create(:user_with_token,
                                   email: "test@mail.com",
                                   username: "test") }
    context "Successful" do
      let(:token) { user.auth_tokens.last }
      let(:payload) {
        {
          email: "test@mail.com",
          password: "passcodeAa"
        }
      }

      let(:succ_response) {
        {
        data: {
            "id": user.id,
            "type": "users",
            "attributes": {
              "username": "test",
              "email": "test@mail.com",
              "authentication": {
                "jwt": token.value,
                "exp": token.expire_at
              }
            }
          }
        }
      }
      before { user }

      # it "successful login" do
      #   post :login, params: payload
      #   expect(response.body).to include_json(succ_response)
      # end
      it "successful login code" do
        post :login, params: payload
        expect(response).to have_http_status(200)
      end
    end

    context "Fail" do
      let(:fail_response) {
        {
          "errors": [
            {
              "title": "Record Not found",
              "status": 404,
              "code": "record_not_found",
              "message": [
                "User not found"
              ]
            }
          ]
        }
      }

      let(:fail_login) {
        {
          "errors": [
            {
              "title": "EchoError",
              "status": 400,
              "code": "Email or password is incorrect",
              "message": [
                "Email or password is incorrect"
              ]
            }
          ]
        }
      }

      let(:incorrect_payload) {
        {
          email: "randomemailaddress@randomemailaddress.com",
          password: "passcodeAadddd"
        }
      }

      let(:incorrect_password) {
        {
          email: "test@mail.com",
          password: "passcodeAadddd"
        }
      }

      let(:invalid_payload) {
        {
          email: "testdatainvalid",
          password: "passcodeAadddd"
        }
      }
      it "User not found" do
        post :login, params: incorrect_payload
        expect(response.body).to include_json(fail_response)
      end

      it "User not found code" do
        post :login, params: incorrect_payload
        expect(response).to have_http_status(404)
      end

      it "email or pass is wrong" do
        user
        post :login, params: incorrect_password
        expect(response.body).to include_json(fail_login)
      end

      it "email or pass is code" do
        user
        post :login, params: incorrect_password
        expect(response).to have_http_status(400)
      end

      it "invalid params get" do
        post :login, params: invalid_payload
        expect(response.body).to include_json(fail_response)
      end
      it "invalid params get code" do
        post :login, params: invalid_payload
        expect(response).to have_http_status(404)
      end
    end
  end
end