module RubyVoluum
  class Campaign
    def initialize(connection)
      @connection = connection
    end

    def find(id:)
      @connection.get("campaign/#{id}")
    end

    def update(id:, data:)
      @connection.put("campaign/#{id}", data)
    end

    def create(data:)
      @connection.put('campaign', data)
    end
  end
end
