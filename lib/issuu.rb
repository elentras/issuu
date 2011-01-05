require "net/http"
require 'net/http/post/multipart'
require 'digest/md5'
require 'uri'
require 'cgi'
require 'active_support'

module Issuu
  
  class << self
    attr_accessor :api_key, :secret
    
    # In your initializer:
    # Issuu.configure do |c|
    #   c.api_key   = ENV['ISSUU_API_KEY']
    #   c.secret   = ENV['ISSUU_SECRET']
    # end
    #
    def configure
      yield self
    end
  end
  
end

require 'issuu/cli'