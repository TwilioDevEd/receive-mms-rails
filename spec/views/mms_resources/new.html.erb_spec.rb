require 'rails_helper'

RSpec.describe "mms_resources/new", type: :view do
  before(:each) do
    assign(:mms_resource, MmsResource.new(
      :filename => "MyString"
    ))
  end

  it "renders new mms_resource form" do
    render

    assert_select "form[action=?][method=?]", mms_resources_path, "post" do

      assert_select "input[name=?]", "mms_resource[filename]"
    end
  end
end
