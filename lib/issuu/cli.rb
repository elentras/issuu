module Issuu
  class Cli
    class << self
      def generate_signature(params)
        string_to_sign = "#{Issuu.secret}#{params.sort_by {|k| k.to_s }.to_s}"
        Digest::MD5.hexdigest(string_to_sign)
      end
      
      def check_for_exceptions(json_data)
        if json_data['rsp']['stat'].eql?("fail")
          raise(StandardError, json_data['rsp']["_content"]["error"]["message"])
        end
      end
      
      def decoded_response_body(response_body)
        json_data = ActiveSupport::JSON.decode(response_body)
        check_for_exceptions(json_data)
        json_data
      end
      
      def http_get(url, params)
        params = params.merge({:signature => Cli.generate_signature(params)})
        path = "#{url.path}?".concat(params.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.reverse.join('&')) unless params.nil?
        request = Net::HTTP.get(url.host, path)
        decoded_response_body(request)
      end
      
      def http_post(url, params)
        params = params.merge({:signature => Cli.generate_signature(params)})
        request = Net::HTTP.post_form(url+ '?', params)
        decoded_response_body(request.body)
      end
      
      def http_multipart_post(url, file, params)
        petition = Net::HTTP::Post::Multipart.new(
          url.path + '?',
          params.merge({:signature => Cli.generate_signature(params), :file => file})
        )
        Net::HTTP.start(url.host, url.port) do |http|
          request = http.request(petition)
          decoded_response_body(request.body)
        end
      end
      
    end
  end
end