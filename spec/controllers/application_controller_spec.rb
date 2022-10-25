require_relative '../rails_helper'

RSpec.describe ApplicationController do
  describe "Rescue" do
    context "RecordNotUnique" do
      controller do
        def index
          raise ::ActiveRecord::RecordNotUnique
        end
      end

      let(:error_check) {
        {
          "errors"=>[
            {
              "title"=>"Record Uniqueness Error",
              "status"=>409,
              "code"=>"record_is_not_uniq",
              "message"=>[
                "ActiveRecord::RecordNotUnique"
              ]
            }
          ]
        }
      }
      it "raises RecordNotUnique" do
        bypass_rescue
        expect { get :index }.to raise_error(::ActiveRecord::RecordNotUnique)
      end

      it "render RecordNotUnique" do
        get :index
        expect(response.body).to include_json(error_check)
      end
    end

    context "RecordNotFound" do
      controller do
        def index
          raise ::ActiveRecord::RecordNotFound
        end
      end

      let(:error_check) {
        {
          "errors"=>[
            {
              "title"=>"Record Not found",
              "status"=>404,
              "code"=>"record_not_found",
              "message"=>[
                " not found"
              ]
            }
          ]
        }
      }
      it "raises RecordNotFound" do
        bypass_rescue
        expect { get :index }.to raise_error(::ActiveRecord::RecordNotFound)
      end

      it "render RecordNotFound" do
        get :index
        expect(response.body).to include_json(error_check)
      end
    end

    context "Record Invalid error" do
      controller do
        def index
          raise ::ActiveRecord::RecordInvalid
        end
      end

      let(:error_check) {
        {
          "errors"=>[
            {
              "title"=>"Record is Invalid",
              "status"=>400,
              "code"=>"record_invalid",
              "message"=>[
                "Record invalid"
              ]
            }
          ]
        }
      }
      it "raises RecordInvalid" do
        bypass_rescue
        expect { get :index }.to raise_error(::ActiveRecord::RecordInvalid)
      end

      it "render RecordInvalid" do
        get :index
        expect(response.body).to include_json(error_check)
      end
    end

    context "Argument Error" do
      controller do
        def index
          raise ::ArgumentError
        end
      end

      let(:error_check) {
        {
          "errors"=>[
            {
              "title"=>"Arguments are Unexpected",
              "status"=>400,
              "code"=>"argument_error",
              "message"=>[
                "ArgumentError"
              ]
            }
          ]
        }
      }
      it "raises Argument" do
        bypass_rescue
        expect { get :index }.to raise_error(::ArgumentError)
      end

      it "render Argument" do
        get :index
        expect(response.body).to include_json(error_check)
      end
    end
  end
end