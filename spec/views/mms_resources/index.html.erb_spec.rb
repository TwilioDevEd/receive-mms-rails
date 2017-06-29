require 'rails_helper'

RSpec.describe "mms_resources/index", type: :view do
  before(:each) do
    assign(:mms_resources, [
      MmsResource.create!(
        :filename => "Filename"
      ),
      MmsResource.create!(
        :filename => "Filename"
      )
    ])
  end

  it "renders a list of mms_resources" do
    render
    assert_select "tr>td", :text => "Filename".to_s, :count => 2
  end
end
