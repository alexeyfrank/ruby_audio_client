module AudioClient
  module MusicPlayer
    
    class Player
    
      def initialize(config = {})
        @config = config
      end
    
      def start
        @pid = fork do
          `cvlc #{@config[:playlist_path]}`
        end
      end
      
      def stop
        Process.kill(@pid) if @pid 
      end
    
    end
    
  end
end