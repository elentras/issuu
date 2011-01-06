module Issuu
  class Folder
    class << self
    
      def add(name, params={})
        url = URI.parse('http://api.issuu.com/1_0?')
        url_upload_params = {
          :action => "issuu.folder.add",
          :apiKey => Issuu.api_key,
          :format => "json",
          :folderName => name
        }
        Cli.http_post(url, url_upload_params.merge(params))
      end
      
      def list(params={})
        url = URI.parse('http://api.issuu.com/1_0')
        list_params = {
          :action => "issuu.folders.list",
          :apiKey => Issuu.api_key,
          :format => "json"
        }
        
        Cli.http_get(url, list_params.merge(params))
      end
      
      def update(folder_id, params={})
        url = URI.parse('http://api.issuu.com/1_0?')
        update_params = {
          :action => "issuu.folder.update",
          :apiKey => Issuu.api_key,
          :format => "json",
          :folderId => folder_id
        }
        
        Cli.http_post(url, update_params.merge(params))
      end
      
      def delete(folder_ids)
        url = URI.parse('http://api.issuu.com/1_0?')
        delete_params = {
          :action => "issuu.folder.delete",
          :apiKey => Issuu.api_key,
          :format => "json",
          :names => folder_ids.join(',')
        }
        
        Cli.http_post(url, url_upload_params)
      end
    
    end
  end
end