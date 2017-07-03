module RubyVoluum
  class Report
    def initialize(options, connection)
      @connection = connection
      @from       = options[:from]     || Date.today
      @to         = options[:to]       || Date.today + 1
      @group_by   = options[:group_by] || 'campaign'
      @include    = options[:include]  || 'active'
      @timezone   = options[:timezone] || 'Europe/Berlin'
      @limit      = options[:limit]    || 1000
      @totals     = nil
      @rows       = nil
    end

    def totals
      @totals ||= content['totals']
    end

    def rows
      @rows ||= content['rows']
    end

    def content
      @content ||= @connection.get('report', query)
    end

    private

    def query
      { limit:    @limit,
        groupBy:  @group_by,
        timezone: @timezone,
        from:     @from.strftime('%Y-%m-%dT%H:00:00Z'),
        to:       @to.strftime('%Y-%m-%dT%H:00:00Z') }
    end
  end
end
