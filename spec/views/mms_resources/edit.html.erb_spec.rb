require 'rails_helper'

RSpec.describe "mms_resources/edit", type: :view do
  before(:each) do
    @mms_resource = assign(:mms_resource, MmsResource.create!(
      :filename => "MyString"
    ))
  end

  it "renders the edit mms_resource form" do
    render

    assert_select "form[action=?][method=?]", mms_resource_path(@mms_resource), "post" do

      assert_select "input[name=?]", "mms_resource[filename]"
    end
  end
end
