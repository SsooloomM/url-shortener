class UrlPresenter
  def initialize(url)
    @url = url
  end

  delegate :original_url, :short_url, to: :@url

  def as_json(template = :default, *)
    respond_to?(template, true) ? send(template) : {}
  end

  private

  def default
    {
      original_url:,
      short_url:
    }
  end
end
