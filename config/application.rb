$:.unshift File.dirname(__FILE__)

require 'bundler/setup'

Bundler.require(:default)

module AudioClient 
  class Application
    
    def self.base_path
      File.dirname(File.dirname(File.expand_path(__FILE__)))
    end
     
    def self.env
      @@env ||= ARGV.length <= 0 ? :dev : ARGV[0]
    end
    
    
    def initialize(&block)
      instance_eval &block
    end
  end
end

require 'config'
require File.dirname(__FILE__) + '/../lib/utils/logger'
require File.dirname(__FILE__) + '/../lib/utils/process_manager'
require File.dirname(__FILE__) + '/../lib/file_updater/file_updater'
require File.dirname(__FILE__) + '/../lib/playlist_builder/playlist_builder'
require File.dirname(__FILE__) + '/../lib/music_player/music_player'


Dropbox::API::Config.app_key    = configus.dropbox_app_key
Dropbox::API::Config.app_secret = configus.dropbox_app_secret
Dropbox::API::Config.mode       = configus.dropbox_app_mode

