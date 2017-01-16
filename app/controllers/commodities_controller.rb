class CommoditiesController < ApplicationController
  def index
    @commodities = Commodity.page(params[:page]).per(params[:per_page])
  end
end
