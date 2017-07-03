module RubyVoluum
  class Connection
    attr_accessor :email, :token, :expire_at

    def initialize(email = nil, password = nil, token = nil)
      @email     = email
      @password  = password
      @token     = token
      @expire_at = @token ? Time.now.utc : nil
    end

    def get(path, query = {})
      authenticatable_request(:get, path, nil, query)
    end

    def post(path, payload)
      authenticatable_request(:post, path, payload)
    end

    def put(path, payload)
      authenticatable_request(:put, path, payload)
    end

    def delete(path)
      authenticatable_request(:delete, path)
    end

    def authenticate!
      response = request(
        :post, 'auth/session',
        email: @email, password: @password
      )
      @token     = response['token']
      @expire_at = Time.parse(response['expirationTimestamp'])
    end

    def authenticated?
      !@token.nil? && !@expire_at.nil? && @expire_at > Time.now.utc
    end

    private

    def authenticatable_request(method, path, payload = {}, query = {})
      authenticate! unless authenticated?
      begin
        request(method, path, payload, query)
      rescue RestClient::Unauthorized
        authenticate!
        request(method, path, payload, query)
      end
    end

    def request(method, url, payload = {}, query = {})
      JSON.parse(
        RestClient::Request.execute(
          url:     "#{API_URL}/#{url}",
          method:  method,
          payload: payload.to_json,
          headers: headers(query)
        )
      )
    end

    def headers(query = {})
      headers = {
        'content-type' => 'application/json',
        'cwauth-token' => @token
      }
      headers['params'] = query if query.any?
      headers
    end
  end
end