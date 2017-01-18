require 'rails_helper'
include ControllerMacros

RSpec.describe CommoditiesController, type: :controller do
  login_admin

  describe "login admin" do
    describe "GET #index" do
      it "returns http success" do
        get :index

        expect(response).to have_http_status(:success)
      end
    end
  end

end
