class Url < ApplicationRecord
  ALPHABET = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_".chars.freeze

  validates :original_url, presence: true, format: URI.regexp(%w[http https])
  validates :short_url, presence: true, uniqueness: true, unless: :new_record?

  after_create :generate_short_code_base63

  def as_json(template = :default, *)
    UrlPresenter.new(self).as_json(template)
  end

  private

  def generate_short_code_base63
    return ALPHABET[0] if id == 0
    temp_id = id

    base = ALPHABET.length
    short_code = ""
    while temp_id > 0
      short_code.prepend(ALPHABET[temp_id % base])
      temp_id /= base
    end
    full_short_url = short_url + short_code
    update_column :short_url, full_short_url
  end
end
