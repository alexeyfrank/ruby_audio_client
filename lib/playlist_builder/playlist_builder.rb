# encoding: utf-8
$:.unshift File.dirname(__FILE__)

require 'builder/builder'

module AudioClient
  module PlaylistBuilder
    def self.build
      
      builder = Builder.new({
        playlist_path: configus.playlist_path,
        sync_dir: configus.sync_dir,
        music_dir: configus.music_dir,
        adv_blocks_dir: configus.adv_blocks_dir,
        blocks_count: configus.blocks_count
      })
      
      puts builder.build(current_day, current_hour, 22)
    end
    
    
    private
    def self.current_day
      days = %w{ monday tuesday wednesday thursday friday saturday sunday }
      time = Time.new
      day = days[time.wday - 1]
    end
    
    def self.current_hour
      Time.new.hour
    end
  end
end