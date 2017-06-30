require 'rails_helper'

RSpec.describe MmsResourcesController, type: :controller do


  before do
    allow(Twilio::REST::Client).to receive_message_chain(:new,
                                                         :api,
                                                         :accounts,
                                                         :messages,
                                                         :media,
                                                         :delete)
  end

  let(:valid_attributes) do
    { NumMedia: num_media,
      MediaContentType0: 'image/jpeg',
      MediaUrl0: 'https://c1.staticflickr.com/3/2899/14341091933_1e92e62d12_b.jpg' }
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context 'given numMedia is zero' do
      let(:num_media) { 0 }

      it 'returns an invitation to send an image when numMedia parameter is zero'do
        post :create, params: valid_attributes
        expect(response.status).to eq(200)
        expect(response.body).to include('Send us an image')
      end
    end

    context 'given numMedia is 1' do
      let(:num_media) { 1 }

      it 'returns an Thank you for the images when numMedia paramter > 0' do
        post :create, params: valid_attributes
        expect(response.status)
        expect(response.body).to include('Thanks for the 1 images')
      end

      it 'deletes media from twilio server' do
        expect(Twilio::REST::Client).to receive_message_chain(:new,
                                                              :api,
                                                              :accounts,
                                                              :messages,
                                                              :media,
                                                              :delete)
        post :create, params: valid_attributes
      end
    end

    context 'given numMedia is bigger than 1' do
      let(:num_media) { 2 }
      let(:multiple_resources) do
        {
          MediaContentType1: 'image/jpeg',
          MediaUrl1: 'https://c1.staticflickr.com/3/2899/14341091933_1e92e62d12_b.jpg'
        }.merge(valid_attributes)
      end

      it 'saves multiple media resources' do
        expect { post :create, params: multiple_resources }
          .to change(MmsResource, :count).by(2)
      end
    end
  end
end
