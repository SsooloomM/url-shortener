require 'rails_helper'

RSpec.describe Url, type: :model do
  describe 'validations' do
    subject { create(:url) }

    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:original_url) }
    it { is_expected.to validate_presence_of(:short_url) }
  end

  describe '#generate_short_url' do
    let(:url) { described_class.create(
      id: 1000, # in our custome base 63 encoding, this should give us fT
      original_url: 'https://example.com',
      short_url: 'https://my.domain/'
    ) }
    it 'generates a unique short_url' do
      expect(url.short_url).to be_present
      expect(url.short_url).to eq 'https://my.domain/fT'
    end

    it 'generates a different short_url for each new record' do
      url1 = create(:url, original_url: 'https://example.com', short_url: 'https://my.domain/')
      url2 = create(:url, original_url: 'https://another-example.com', short_url: 'https://my.domain/')

      expect(url1.short_url).not_to eq(url2.short_url)
    end
  end
end
