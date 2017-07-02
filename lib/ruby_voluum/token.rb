module RubyVoluum
  class Token
    attr_reader :token, :expiry_at

    def initialize(params)
      @token     = params['token']
      @expiry_at = Time.parse(params['expirationTimestamp'])
    end

    def expired?
      Time.now.utc > @expiry_at
    end
  end
end
