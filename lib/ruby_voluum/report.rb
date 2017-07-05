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

    # POST /report/manual-cost
    # updates the cost of given campaign in given time interval.
    # Voluum accepts time in hours, so it'll cut minutes and seconds.
    # 2017-02-07T14:56:57.1234 will be sent as  => 2017-02-07T14:00:00.
    #
    # @param [Hash] :from (Time/Date), :to (Time/Date), :cost (Numeric) :timezone (String), :campaign_id (String)
    # @return [TrueClass] true if successful
    def update_cost(params)
      params[:from] = to_rounded_s(params[:from] || Time.now.utc.to_date)
      params[:to]   = to_rounded_s(params[:to] || Time.now.utc)
      params[:cost] = params[:cost].to_f
      params[:timezone] ||= 'UTC'
      params[:campaignId] ||= params.delete(:campaign_id)
      @connection.post('report/manual-cost', params)
    end

    def content
      @content ||= @connection.get('report', query)
    end

    private

    def query
      { limit:    @limit,
        groupBy:  @group_by,
        tz:       @timezone,
        include:  @include,
        from:     to_rounded_s(@from),
        to:       to_rounded_s(@to) }
    end

    def to_rounded_s(value)
      value.strftime('%Y-%m-%dT%H:00:00')
    end
  end
end
