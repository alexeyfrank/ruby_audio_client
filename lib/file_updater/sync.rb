# encoding: utf-8
require "fileutils"

module AudioClient
  module FileUpdater
    class Sync
      include AudioClient::Utils
      include AudioClient::FileUpdater::Db
      
      def initialize(config = {}) 
        @config = config
      end

      EXCLUDED_LOCAL_PATHS=[".", "..", "log"]

      def fetch_from_remote
        files_found = []
        folders_to_search = [ base_path ]
    
        while folder = folders_to_search.pop
          client.ls(folder).each do |entry|
            files_found << entry.path
            local_path = File.join(sync_dir, entry.path)
            e = Entry.new :remote_entry => entry, :local_path => local_path

            folders_to_search << entry.path if entry.is_a? Dropbox::API::Dir

            if e.remote_newer?
              e.update_local do
                if entry.is_a? Dropbox::API::Dir
                  FileUtils.mkdir_p local_path
                else
                  File.open(local_path, "w") do |f|
                    logger.info("Начинаем загрузку файла #{ entry.path } с сервера ...")
                    f.write(client.download(entry.path))
                    logger.info("Файл #{ entry.path } успешно загружен\n")
                  end
                end
                File.mtime local_path
              end
            end
          end
        end
        files_found
      end

      def delete_from_local(files_found)
        Entry.all.each do |e|
          unless files_found.include? e.path
            e.delete do
              path = File.join(sync_dir, e.path)
              logger.info "Удаляем: #{ path } ..."
              FileUtils.rm_rf path 
              logger.info("Файл #{ path } успешно удален\n")
            end
          end
        end
      end

      def push_from_local
        files_found = []
        folders_to_search = [ "#{sync_dir}/log/" ]
        while folder = folders_to_search.pop
          Dir.foreach(folder) do |f|
            next if EXCLUDED_LOCAL_PATHS.include? f

            local_path = File.join(folder,f)
            remote_path = local_path[sync_dir.size + 1..local_path.size]
            files_found << remote_path

            e = Entry.new :remote_path => remote_path, :local_path => local_path

            if File.directory? local_path
              folders_to_search << local_path
            end

            if e.local_newer?
              e.update_remote do
                if File.directory? local_path
                  begin
                    client.mkdir remote_path
                  rescue Dropbox::API::Error::Forbidden => e
                    raise e unless e.message.include? "already exists."
                  end
                  if File.dirname(remote_path) == "."
    	              client.search(File.basename(remote_path)).first.modified
                  else
                    client.search(File.basename(remote_path), :path => File.dirname(remote_path)).first.modified
                  end
                else
                  logger.info("Загружаем файл #{remote_path} на сервер ...")
                  client.upload(remote_path, open(local_path).read)
                  logger.info("Файл #{remote_path} успешно загружен")
                  client.find(remote_path).modified
                end
              end
            end
          end
        end
        files_found
      end

      def delete_from_remote(files_found)
        Entry.all.each do |e|
          unless files_found.include? e.path
            e.delete do
              begin
                client.raw.delete :path => e.path
              rescue Dropbox::API::Error::NotFound # it was already deleted
              end
            end
          end
        end
      end

      def write_log_file
        current_time = Time.now + 4.hours # add 4 hours
        current_time = current_time.strftime("%Y-%m-%d в %H:%M:%S")
        logger.prepend_plain(current_time)
        logger.prepend_plain(shop_address)
      end
      # 
      # def sync!
      #   logger.info("Загружаем файлы с удаленного сервера")
      #   files = Sync.fetch_from_remote
      # 
      #   logger.info("Удаляем отсутствующие файлы с локального компьютера")
      #   self.delete_from_local(files)
      # 
      #   logger.info("Создаем и записываем файл логов")
      #   self.write_log_file
      # 
      #   logger.info("Отправляем файл логов на сервер")
      #   files = self.push_from_local
      # end
  
      def logger
        @logger ||= Logger.new(file: "#{sync_dir}/log/#{log_filename}")
      end
      
      private 
        def base_path
          ""
        end
  
        def sync_dir
          @config[:sync_dir]
        end
  
        def log_filename
          @config[:shop_log_filename]
        end
  
        def shop_address
          @config[:shop_address]
        end
  
        def client
          @client ||= Dropbox::API::Client.new(token: @config[:access_token],
                                                secret: @config[:access_secret])  
        end
    end
  end
end
