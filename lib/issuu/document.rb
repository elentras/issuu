module Issuu
  class Document
    attr_accessor :hash
    
    def initialize(hash)
      @hash = hash
    end
    
    class << self
      def url_upload(url, params={})
        response = Cli.http_post(
          Issuu::API_URL,
          Parameter.new("issuu.document.url_upload", params.merge({:slurpUrl => url})).output
        )
        Document.new(response["rsp"]["_content"]["document"])
      end
      
      def upload(file_path, file_type, params={})
        file_to_upload = UploadIO.new(file_path, file_type)
        
        response = Cli.http_multipart_post(
          Issuu::API_UPLOAD_URL,
          file_to_upload,
          ParameterSet.new("issuu.document.upload", params).output
        )
        Document.new(response["rsp"]["_content"]["document"])
      end
      
      def update(filename, params={})
        response = Cli.http_post(
          Issuu::API_URL,
          ParameterSet.new("issuu.document.update", params.merge({:name => filename})).output
        )
        Document.new(response["rsp"]["_content"]["document"])
      end
      
      def list(params={})        
        response = Cli.http_get(
          Issuu::API_URL,
          ParameterSet.new("issuu.documents.list", params).output
        )
        response["rsp"]["_content"]["result"]["_content"].map{|document_hash| Document.new(document_hash["document"]) }
      end
      
      def delete(filenames)        
        Cli.http_post(
          Issuu::API_URL,
          ParameterSet.new("issuu.document.delete", {:names => filenames.join(',')}).output
        )
        return true
      end
    end
  end
end