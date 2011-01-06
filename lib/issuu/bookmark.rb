module Issuu
  class Bookmark
    class << self
    
      def add(name, document_user_name, params={})
        Cli.http_post(
          Issuu::API_URL,
          ParameterSet.new("issuu.bookmark.add", params.merge({:name => name, :documentUsername => document_user_name})).output
        )
      end
      
      def list(params={})        
        Cli.http_get(
          Issuu::API_URL,
          ParameterSet.new("issuu.bookmarks.list", params).output
        )
      end
      
      def update(bookmark_id, params={})        
        Cli.http_post(
          Issuu::API_URL,
          ParameterSet.new("issuu.bookmark.update", params.merge({:bookmarkId => bookmark_id})).output
        )
      end
      
      def delete(bookmark_ids)        
        Cli.http_post(
          Issuu::API_URL,
          ParameterSet.new("issuu.bookmark.delete", params.merge({:bookmarkIds => bookmark_ids.join(',')})).output
        )
      end
    
    end
  end
end