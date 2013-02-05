module AudioClient
  module Utils
    class ProcessManager  
      
      def self.start_process(cmd)
        `#{cmd}`
      end
      
      def self.kill_all_processes
        current_pid = Process.pid
        pids = self.get_pids('script/run') + self.get_pids('client.sh')
        pids = pids.delete(current_pid)
        self.kill_processes pids
      end
      
      def self.kill_vlc
        pids = self.get_pids('vlc')
        puts "VLC player PIDs: #{pids.inspect}"
        self.kill_processes pids
      end
      
      private 
        def self.get_pids(name)
          str = `ps aux | grep #{name} | grep -v grep | awk '{ print $2 }'`
          str.split(/\n/)
        end
        
        def self.kill_processes(pids)
          pids.each { |pid| self.kill_process(pid) } if pids
        end
        
        def self.kill_process(pid)
          `kill #{pid}`
        end
    end
  end
end