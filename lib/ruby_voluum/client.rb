module RubyVoluum
  # basic class to that'll provide access to other API
  class Client
    attr_reader :connection

    def initialize(email: nil, password: nil, token: nil)
      @connection = Connection.new(email, password, token)
    end

    def campaign
      Campaign.new(@connection)
    end

    def report(options = {})
      Report.new(options, @connection)
    end

    def miscellaneous
      Miscellaneous.new(@connection)
    end
  end
end
