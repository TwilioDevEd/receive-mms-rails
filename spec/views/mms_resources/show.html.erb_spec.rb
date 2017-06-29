require 'rails_helper'

RSpec.describe "mms_resources/show", type: :view do
  before(:each) do
    @mms_resource = assign(:mms_resource, MmsResource.create!(
      :filename => "Filename"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Filename/)
  end
end
