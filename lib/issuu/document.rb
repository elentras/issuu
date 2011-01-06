module Issuu
  class Document
    class << self      
      def url_upload(url, params={})
        url_upload_params = {
          :action => "issuu.document.url_upload",
          :apiKey => Issuu.api_key,
          :format => "json",
          :slurpUrl => url
        }
        Cli.http_post(Issuu::API_URL, url_upload_params.merge(params))
      end
      
      def upload(file_path, file_type, params={})
        file_to_upload = UploadIO.new(file_path, file_type)
        upload_params = {
          :action           => "issuu.document.upload",
          :apiKey           => Issuu.api_key,
          :format           => "json",
        }
        
        Cli.http_multipart_post(Issuu::API_UPLOAD_URL, file_to_upload, upload_params.merge(params))
      end
      
      def update(filename, params={})
        update_params = {
          :action => "issuu.document.update",
          :apiKey => Issuu.api_key,
          :format => "json",
          :name => filename
        }
        
        Cli.http_post(Issuu::API_URL, update_params.merge(params))
      end
      
      def list(params={})
        list_params = {
          :action => "issuu.documents.list",
          :apiKey => Issuu.api_key,
          :responseParams => "title,description",
          :format => "json"
        }
        
        Cli.http_get(Issuu::API_URL, list_params.merge(params))
      end
      
      def delete(filenames)
        delete_params = {
          :action => "issuu.document.delete",
          :apiKey => Issuu.api_key,
          :format => "json",
          :names => filenames.join(',')
        }
        
        Cli.http_post(Issuu::API_URL, delete_params)
      end
    end
  end
end