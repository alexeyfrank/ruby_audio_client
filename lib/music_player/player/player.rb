require 'fileutils'

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
        
        # save_pid @pid
      end
      
      def stop
        stop_all_processes
        # Process.kill(@pid) if @pid 
      end
      
      
      def stop_all_processes
        #pids_path = "#{Application.base_path}/pids/"
        #FileUtils.mkdir_p(pids_path) unless Dir.exist?(pids_path)
        
        pids = get_vlc_pids
        pids.each do |pid|
          `kill #{pid}`
          #Process.kill("TERM", pid)
          #FileUtils.rm "#{pids_path}#{pid}"
        end
      end
      
      def save_pid(pid)
        #file_path = "#{Application.base_path}/pids/#{pid}"
        #FileUtils.touch(file_path) unless File.exist?(file_path)
      end
      
      private 
      def get_vlc_pids
        str = `ps aux | grep vlc | grep -v grep | awk '{ print $2 }'`
        str.split(/\n/)
      end
      
    end
    
  end
end