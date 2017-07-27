module RubyVoluum
  class Logger
    class << self
      attr_accessor :log_file_path

      def log(response, request, result)
        request_date = DateTime.now.strftime('%d-%m-%Y %H:%M')
        request_info = "#{request.method.upcase} #{request.url}"
        response_info = result.code.to_s

        if ('200'..'299').exclude?(result.code)
          response_message = result.message
          description = error_description(response)
          response_message << ": #{description}" if description
          response_info = "#{response_info} `#{response_message}`"
        end

        message = "[#{request_date}] -- \"#{request_info}\" | #{response_info}"

        File.open(log_file_path, 'a') { |f| f.write "#{message}\n" } if log_file_path

        message = "  VoluumClient: #{message}"
        message = ('200'..'299').cover?(result.code) ? message.green : message.red
        puts message
      end

      private

      def error_description(response)
        JSON.parse(response.body)['error']['description']
      rescue
        nil
      end
    end
  end
end
