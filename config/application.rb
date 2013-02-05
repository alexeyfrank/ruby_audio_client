$:.unshift File.dirname(__FILE__)

require 'bundler/setup'

Bundler.require(:default)

module AudioClient 
  class Application
    
    def self.base_path
      File.dirname(File.dirname(File.expand_path(__FILE__)))
    end
     
    def self.env
      :dev
    end
    
    
    def initialize(env, &block)
      @@env = env
      instance_eval &block
    end
  end
end

require 'config'
require File.dirname(__FILE__) + '/../lib/utils/logger'
require File.dirname(__FILE__) + '/../lib/file_updater/file_updater'
require File.dirname(__FILE__) + '/../lib/playlist_builder/playlist_builder'
require File.dirname(__FILE__) + '/../lib/music_player/music_player'
