module Issuu
  class Folder
    class << self
    
      def add(name, params={})
        Cli.http_post(
          Issuu::API_URL,
          ParameterSet.new("issuu.folder.add", params.merge(:folderName => name)).output
        )
      end
      
      def list(params={})        
        Cli.http_get(
          Issuu::API_URL, 
          ParameterSet.new("issuu.folders.list", params).output
        )
      end
      
      def update(folder_id, params={})    
        Cli.http_post(
          Issuu::API_URL,
          ParameterSet.new("issuu.folder.update", params.merge(:folderId => folder_id)).output
        )
      end
      
      def delete(folder_ids)        
        Cli.http_post(
          Issuu::API_URL,
          ParameterSet.new("issuu.folder.delete", params.merge(:names => folder_ids.join(','))).output
        )
      end
    
    end
  end
end