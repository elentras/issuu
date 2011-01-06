module Issuu
  class Bookmark
    class << self
    
      def add(name, document_user_name, params={})
        url = URI.parse('http://api.issuu.com/1_0?')
        url_upload_params = {
          :action => "issuu.bookmark.add",
          :apiKey => Issuu.api_key,
          :format => "json",
          :name => name,
          :documentUsername => document_user_name
        }
        Cli.http_post(url, url_upload_params.merge(params))
      end
      
      def list(params={})
        url = URI.parse('http://api.issuu.com/1_0')
        list_params = {
          :action => "issuu.bookmarks.list",
          :apiKey => Issuu.api_key,
          :format => "json"
        }
        
        Cli.http_get(url, list_params.merge(params))
      end
      
      def update(bookmark_id, params={})
        url = URI.parse('http://api.issuu.com/1_0?')
        update_params = {
          :action => "issuu.bookmark.update",
          :apiKey => Issuu.api_key,
          :format => "json",
          :bookmarkId => bookmark_id
        }
        
        Cli.http_post(url, update_params.merge(params))
      end
      
      def delete(bookmark_ids)
        url = URI.parse('http://api.issuu.com/1_0?')
        delete_params = {
          :action => "issuu.bookmark.delete",
          :apiKey => Issuu.api_key,
          :format => "json",
          :names => bookmark_ids.join(',')
        }
        
        Cli.http_post(url, url_upload_params)
      end
    
    end
  end
end