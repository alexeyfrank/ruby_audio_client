# encoding: utf-8
$:.unshift File.dirname(__FILE__)

require 'player/player'

module AudioClient
  module MusicPlayer
    
    def self.start
      @@player = Player.new(playlist_path: configus.playlist_path)
      @@player.start
    end
    
    def self.stop
      @@player.stop
    end
    
  end
end