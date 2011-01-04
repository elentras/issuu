require 'net/http/post/multipart'
require 'active_support'

module Issuu
  
  class << self
    attr_accessor :api_key
    
    # In your initializer:
    # Issuu.configure do |c|
    #   c.api_key   = ENV['ISSUU_API_KEY']
    # end
    #
    def configure
      yield self
    end
  end
  
end

require 'issuu/cli'