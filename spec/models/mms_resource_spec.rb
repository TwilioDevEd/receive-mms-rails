require 'rails_helper'

RSpec.describe MmsResource, type: :model do

  describe '#is_image?' do
    context 'given an image mms resource' do
      subject(:image_resource) { described_class.new(filename: 'test.jpg') }

      it 'confirms its type' do
        expect(image_resource.is_image?).to eq(true)
      end
    end

    context 'given an video mms resource' do
      subject(:image_resource) { described_class.new(filename: 'test.mov') }

      it 'confirms its type' do
        expect(image_resource.is_image?).to eq(false)
      end
    end
  end

  describe '#path' do
    it 'returns path for the local file' do
      resource = described_class.new(filename: 'test.jpg')
      expect(resource.path).to eq('./public/test.jpg')
    end
  end
end
