module Issuu
  class Folder
    class << self
    
      def add(name, params={})
        url_upload_params = {
          :action => "issuu.folder.add",
          :apiKey => Issuu.api_key,
          :format => "json",
          :folderName => name
        }
        Cli.http_post(url, url_upload_params.merge(params))
      end
      
      def list(params={})
        list_params = {
          :action => "issuu.folders.list",
          :apiKey => Issuu.api_key,
          :format => "json"
        }
        
        Cli.http_get(Issuu::API_URL, list_params.merge(params))
      end
      
      def update(folder_id, params={})
        update_params = {
          :action => "issuu.folder.update",
          :apiKey => Issuu.api_key,
          :format => "json",
          :folderId => folder_id
        }
        
        Cli.http_post(Issuu::API_URL, update_params.merge(params))
      end
      
      def delete(folder_ids)
        delete_params = {
          :action => "issuu.folder.delete",
          :apiKey => Issuu.api_key,
          :format => "json",
          :names => folder_ids.join(',')
        }
        
        Cli.http_post(Issuu::API_URL, url_upload_params)
      end
    
    end
  end
end