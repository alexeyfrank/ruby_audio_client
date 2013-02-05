module AudioClient
  module Utils
    class ProcessManager  
      
      def self.start_process(cmd)
        `#{cmd}`
      end
      
      def self.kill_all_processes
        puts current_pid = Process.pid
        pids = self.get_pids('ruby_audio_client/script')
        puts pids.include?(current_pid)
        pids = pids.delete(current_pid)
        self.kill_processes pids
      end
      
      def self.kill_vlc
        self.kill_processes self.get_pids('vlc')  
      end
      
      private 
        def self.get_pids(name)
          str = `ps aux | grep #{name} | grep -v grep | awk '{ print $2 }'`
          str.split(/\n/)
        end
        
        def self.kill_processes(pids)
          pids.each { |pid| self.kill_process(pid) }
        end
        
        def kill_process(pid)
          `kill #{pid}`
        end
    end
  end
end