module RubyVoluum
  API_URL = 'https://api.voluum.com'.freeze

  # basic class to that'll provide access to other API
  class Client
    attr_reader :token

    def initialize(email: nil, password: nil, access_key: nil)
      use_email = email.is_a?(String) && password.is_a?(String)
      raise ArgumentError if !use_email && !access_key.is_a?(String)

      response = RestClient.post(
        "#{API_URL}/auth/session",
        { email: email, password: password }.to_json,
        content_type: 'application/json'
      )

      @token = JSON.parse(response.body)['token']
    rescue RestClient::Unauthorized
      raise RubyVoluum::Exceptions::NotAuthorizedError
    end

    def report
      RubyVoluum::Report.new
    end
  end
end
