module AudioClient
  module Utils
    class Logger
    
      def initialize(params = {}) 
        @file = params[:file]
        unless Dir.exist? File.dirname(@file)
          FileUtils.mkdir_p File.dirname(@file)
        end
        puts "File is exist? #{File.exist? @file}"
        if File.exist? @file
          File.delete @file
        end
        puts "File is exist? #{File.exist? @file}"
      end
  
      def info(msg)
        text = "INFO #{timestamp}: #{msg}"
        puts text
        append_to_file(text)
      end
  
      def error(msg)
        text = "ERROR #{timestamp}: #{msg}"
        puts text
        append_to_file(text)
      end
  
      def prepend_plain(msg) 
        prepend_to_file(msg)
      end
  
      private 
        def timestamp
          Time.now + (4*60*60)
        end
      
        def append_to_file(msg)
          File.open(@file, 'a') do |f|
            f.write("#{msg}\n")
          end
        end
    
        def prepend_to_file(msg)
          text = File.open(@file){ |file| file.read }
          File.open(@file, 'w') do |f|
            f.write("#{msg}\n#{text}")
          end
        end
    end
  end
end