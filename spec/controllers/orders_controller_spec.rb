require 'rails_helper'
include ControllerMacros

RSpec.describe OrdersController, type: :controller do
  before(:all) do
    @commodity = Commodity.first
  end
  login_admin

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, commodity_id: @commodity.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "returns http success" do
      post :create, commodity_id: @commodity.id, price: 100, count: 10
      expect(flash[:success]).to eq "订单创建成功!"
    end
  end
end
