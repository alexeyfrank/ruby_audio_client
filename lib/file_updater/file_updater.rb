# encoding: utf-8
$:.unshift File.dirname(__FILE__)

require 'singleton'
require 'time'
require 'fileutils'
require 'yaml'

require 'db/entry'
require 'db/mapping_database'
require 'sync'

# the database is in UTC
ENV["TZ"] = "UTC"

module AudioClient
  module FileUpdater
    
    def self.start
      before_sync_timeout = configus.timeout_before_sync
      puts "Подготовка к началу синхронизации файлов (#{before_sync_timeout} секунд)..."

      times = 1..before_sync_timeout
      times.each do |i|
        puts "#{ before_sync_timeout - i}..."
        sleep(1)
      end

      puts "Начало синхронизации..."
      
      sync = Sync.new({
                        sync_dir: configus.sync_dir,
                        shop_address: configus.shop.address,
                        shop_log_filename: configus.shop.log_filename,
                        access_token: configus.dropbox_access_token,
                        access_secret: configus.dropbox_access_secret
                      })
                      
      begin
        sync.logger.info("Загружаем файлы с удаленного сервера")
        files = sync.fetch_from_remote

        sync.logger.info("Удаляем отсутствующие файлы с локального компьютера")
        sync.delete_from_local(files)

        sync.logger.info("Создаем и записываем файл логов")
        sync.write_log_file

        sync.logger.info("Отправляем файл логов на сервер")
        files = sync.push_from_local                
      rescue Exception => e
        #if e.is_a?(SocketError) || e.is_a?(Timeout::Error)
        sync.logger.error "Произошла ошибка класса: #{ e.class }"
        sync.logger.error "Сообщение об ошибке: #{ e.message }"
        sync.logger.error "Backtrace: #{e.backtrace}"
    
        sleeping_timeout = configus.sleeping_time_out
        puts "Таймаут до перезапуска: #{sleeping_timeout} секунд ..."
        sleep(sleeping_timeout)
        retry
      end
      
    end
  end
end