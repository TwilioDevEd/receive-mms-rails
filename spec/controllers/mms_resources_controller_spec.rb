require 'rails_helper'

describe MmsResourcesController, type: :controller do
  describe '#index' do
    let(:files) { [ double(:files) ] }

    before do
      allow(MmsResource).to receive(:all) { files }
      get :index
    end

    it 'assigns @files' do
      expect(assigns(:files)).to eq(files)
    end

    it { is_expected.to respond_with :ok }
  end

  describe '#create' do
    let(:twilio_request_params) do
      {
        NumMedia: 1,
        MediaContentType0: 'image/jpeg',
        MediaUrl0: 'https://c1.staticflickr.com/3/2899/14341091933_1e92e62d12_b.jpg',
        MessageSid: 'MMd48e71771d0e65ec0db7964d261bc6ff'
      }
    end

    before do |example|
      expect_any_instance_of(Twilio::REST::Client)
        .to receive_message_chain(:api, :accounts, :messages, :media, :delete)
      unless example.metadata[:skip_on_before]
        post :create, params: twilio_request_params
      end
    end

    it 'saves the resource to the database', :skip_on_before do
      expect { post :create, params: twilio_request_params }
        .to change(MmsResource, :count).by(1)
    end

    it 'responds with a message' do
      expect(response.body).to include('Thanks for the images')
    end

    it { is_expected.to respond_with :ok }
  end
end
