require "json"
require "httparty"

class ShortUrlService
  include HTTParty
  base_uri "https://api.short.io/"
  headers "Accept" => "application/json"
  headers "Content-Type" => "application/json"

  def initialize(short_domain = nil, api_key = nil)
    @short_domain = short_domain
    @short_api_key = api_key
    @short_url = nil
  end

  # return response containing body, headers ...ect in a hash
  # currently, only need short url from body
  # refer to docs: https://developers.short.io/docs/cre
  def create_short_url(original_url = nil)
    params = {body: {originalURL: original_url, domain: @short_domain}.to_json, headers: {"Authorization" => @short_api_key}}
    response = self.class.post("/links", params)
    @short_url = JSON.parse(response.body)["shortURL"]
    response
  end

  def get_short_url
    @short_url
  end
end
