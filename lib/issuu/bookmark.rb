module Issuu
  class Bookmark
    class << self
    
      def add(name, document_user_name, params={})
        url_upload_params = {
          :action => "issuu.bookmark.add",
          :apiKey => Issuu.api_key,
          :format => "json",
          :name => name,
          :documentUsername => document_user_name
        }
        Cli.http_post(Issuu::API_URL, url_upload_params.merge(params))
      end
      
      def list(params={})
        list_params = {
          :action => "issuu.bookmarks.list",
          :apiKey => Issuu.api_key,
          :format => "json"
        }
        
        Cli.http_get(Issuu::API_URL, list_params.merge(params))
      end
      
      def update(bookmark_id, params={})
        update_params = {
          :action => "issuu.bookmark.update",
          :apiKey => Issuu.api_key,
          :format => "json",
          :bookmarkId => bookmark_id
        }
        
        Cli.http_post(Issuu::API_URL, update_params.merge(params))
      end
      
      def delete(bookmark_ids)
        delete_params = {
          :action => "issuu.bookmark.delete",
          :apiKey => Issuu.api_key,
          :format => "json",
          :names => bookmark_ids.join(',')
        }
        
        Cli.http_post(Issuu::API_URL, url_upload_params)
      end
    
    end
  end
end