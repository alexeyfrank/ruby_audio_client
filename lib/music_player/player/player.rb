require 'fileutils'

module AudioClient
  module MusicPlayer
    
    class Player
    
      def initialize(config = {})
        @config = config
      end
    
      def start
        `cvlc #{@config[:playlist_path]}`
      end
      
      def stop
        stop_all_processes
      end
      
      
      def stop_all_processes
        pids = get_vlc_pids
        pids.each do |pid|
          `kill #{pid}`
        end
      end
      
      
      private 
      def get_vlc_pids
        str = `ps aux | grep vlc | grep -v grep | awk '{ print $2 }'`
        str.split(/\n/)
      end
      
    end
    
  end
end