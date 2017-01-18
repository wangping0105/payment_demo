require 'rails_helper'

RSpec.describe "commodities/index.html.erb", type: :view do
  it "displays product details correctly" do
    assign(:commodities, Commodity.all)
    render

    expect(rendered).to include('洗发露(中)')
    expect(rendered).to include('188')
  end
end
