require 'rails_helper'

describe Api::ShortenersController, type: :controller do
  describe 'POST #encode' do
    context 'with valid original_url' do
      it 'creates a short URL and returns it' do
        post :encode, params: { original_url: 'https://example.com' }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['url']).to be_present
      end
    end

    context 'without original_url' do
      it 'returns an error' do
        post :encode, params: {}
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['error']).to eq(I18n.t('shortener.errors.missing_original_url'))
      end
    end

    context 'with an invalid original_url' do
      it 'returns an error' do
        post :encode, params: { original_url: 'invalid-url' }
        expect(response).to have_http_status(:unprocessable_content)
        expect(JSON.parse(response.body)['error']).to eq("Validation failed: Original url is invalid")
      end
    end
  end

  describe 'GET #decode' do
    let!(:url) { Url.create!(original_url: 'https://example.com', short_url: 'http://short.ly/abc123') }

    context 'with valid short_url' do
      it 'returns the original URL' do
        get :decode, params: { short_url: url.short_url }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['url']).to be_present
      end
    end

    context 'with invalid short_url' do
      it 'returns an error' do
        get :decode, params: { short_url: 'http://short.ly/invalid' }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq(I18n.t('shortener.errors.short_url_not_found'))
      end
    end

    context 'without short_url' do
      it 'returns an error' do
        get :decode, params: {}
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['error']).to eq(I18n.t('shortener.errors.missing_short_url'))
      end
    end
  end
end
