require "rails_helper"

RSpec.describe MmsResourcesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/mms_resources").to route_to("mms_resources#index")
    end

    it "routes to #new" do
      expect(:get => "/mms_resources/new").to route_to("mms_resources#new")
    end

    it "routes to #show" do
      expect(:get => "/mms_resources/1").to route_to("mms_resources#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/mms_resources/1/edit").to route_to("mms_resources#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/mms_resources").to route_to("mms_resources#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/mms_resources/1").to route_to("mms_resources#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/mms_resources/1").to route_to("mms_resources#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/mms_resources/1").to route_to("mms_resources#destroy", :id => "1")
    end

  end
end
