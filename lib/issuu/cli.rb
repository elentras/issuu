module Issuu
  class Cli
    class << self
      def default_upload_params
        {
          :access           => "private",
          :action           => "issuu.document.upload",
          #:description      =>  "",
          #:downloadable     => true,
          :commentsAllowed  => false,
          :ratingsAllowed   => false,
          :apiKey           => Issuu.api_key,
          :format           => "json",
          #:name             => "test"
        }
      end
      
      def upload(file_path, file_type, params={})
        file_to_upload = UploadIO.new(file_path, file_type)
        url = URI.parse('http://upload.issuu.com/1_0?')
        upload_params = default_upload_params.update(params)

        petition = Net::HTTP::Post::Multipart.new(
          url.path,
          upload_params.merge({:signature => generate_signature(upload_params) , :file => file_to_upload})
        )
        puts petition.inspect
        Net::HTTP.start(url.host, url.port) do |http|
          request = http.request(petition)
          json_data = ActiveSupport::JSON.decode(request.body)
          check_for_exceptions(json_data)           
          documentId = json_data['rsp']['_content']['document']['documentId']
        end
      end
      
      def list(params={})
        url = URI.parse('http://api.issuu.com/1_0')
        list_params = {
          :action => "issuu.documents.list",
          :apiKey => Issuu.api_key,
          :responseParams => "title,description",
          :format => "json"
        }
        request = http_get(url.host, url.path, list_params.merge({:signature => generate_signature(list_params)}))
        json_data = ActiveSupport::JSON.decode(request)
        check_for_exceptions(json_data)
        results = json_data['rsp']['_content']
      end
      
      def delete(filenames)
        url = URI.parse('http://api.issuu.com/1_0?')
        delete_params = {
          :action => "issuu.document.delete",
          :apiKey => Issuu.api_key,
          :format => "json",
          :names => filenames.join(',')
        }
        
        request = Net::HTTP.post_form(url, delete_params.merge({:signature => generate_signature(delete_params)}))
        json_data = ActiveSupport::JSON.decode(request.body)
        check_for_exceptions(json_data)
      end
      
      def generate_signature(params)
        string_to_sign = "#{Issuu.secret}#{params.sort_by {|k| k.to_s }.to_s}"
        Digest::MD5.hexdigest(string_to_sign)
      end
      
      def check_for_exceptions(json_data)
        if json_data['rsp']['stat'].eql?("fail")
          raise(StandardError, json_data['rsp']["_content"]["error"]["message"])
        end
      end
      
      def http_get(domain,path,params)
        path = "#{path}?".concat(params.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.reverse.join('&')) unless params.nil?
        return Net::HTTP.get(domain, path)
      end
      
    end
  end
end