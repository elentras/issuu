module Issuu
  class Document
    class << self      
      def url_upload(url, params={})
        Cli.http_post(
          Issuu::API_URL,
          Parameter.new("issuu.document.url_upload", params.merge({:slurpUrl => url})).output
        )
      end
      
      def upload(file_path, file_type, params={})
        file_to_upload = UploadIO.new(file_path, file_type)
        
        Cli.http_multipart_post(
          Issuu::API_UPLOAD_URL,
          file_to_upload,
          ParameterSet.new("issuu.document.upload", params).output
        )
      end
      
      def update(filename, params={})
        Cli.http_post(
          Issuu::API_URL,
          ParameterSet.new("issuu.document.update", params.merge({:name => filename})).output
        )
      end
      
      def list(params={})        
        Cli.http_get(
          Issuu::API_URL,
          ParameterSet.new("issuu.documents.list", params).output
        )
      end
      
      def delete(filenames)        
        Cli.http_post(
          Issuu::API_URL,
          ParameterSet.new("issuu.document.delete", {:names => filenames.join(',')}).output
        )
      end
    end
  end
end