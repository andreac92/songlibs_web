class Genius
	include HTTParty

	def initialize
		@token = Rails.application.secrets.genius_token
		@base_uri = 'http://api.genius.com'
		@public_uri = 'https://genius.com'
	end

	def send_request url, data
		headers = { 'Authorization' => "Bearer #{@token}" }
		HTTParty.get(url, headers: headers, query: data )
	end

	def search query
		response = send_request @base_uri + '/search', q: query
		response.code == 200 ? JSON.parse(response.body) : nil
	end

	def scrape path
		response = HTTParty.get(@public_uri + path)
		response.code == 200 ? response.body : nil
	end
end
