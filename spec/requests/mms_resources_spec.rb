require 'rails_helper'

RSpec.describe "MmsResources", type: :request do
  describe "GET /mms_resources" do
    it "works! (now write some real specs)" do
      get mms_resources_path
      expect(response).to have_http_status(200)
    end
  end
end
