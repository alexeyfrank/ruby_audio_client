require 'fileutils'

module AudioClient
  module MusicPlayer
    
    class Player
    
      def initialize(config = {})
        @config = config
      end
    
      def start
        Utils::ProcessManager.start_process("cvlc #{@config[:playlist_path]}")
      end
      
      def stop
        Utils::ProcessManager.kill_vlc
      end
    
    end
  end
end