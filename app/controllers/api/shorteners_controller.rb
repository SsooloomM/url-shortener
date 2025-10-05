class Api::ShortenersController < ApplicationController
  def encode
    original_url = params[:original_url]
    if original_url.present?
      url = Url.create!(original_url:, short_url: "#{request.base_url}/")
      render json: { url: }
    else
      render json: { error: I18n.t("shortener.errors.missing_original_url") }, status: :bad_request
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def decode
    short_url = params[:short_url]
    render json: { error: I18n.t("shortener.errors.missing_short_url") }, status: :bad_request and return if short_url.blank?

    url = Url.find_by(short_url:)
    if url.present?
      render json: { url: }
    else
      render json: { error: I18n.t("shortener.errors.short_url_not_found") }, status: :not_found
    end
  end
end
