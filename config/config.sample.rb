# encoding: utf-8

Configus.build :dev do
  env :dev do
    timeout_before_sync 10
    sleeping_time_out 5
    
    dropbox_app_key "29sx8gw6l0b0nnv"
    dropbox_app_secret "i5ecioot61yszja"
    dropbox_app_mode "sandbox"
    dropbox_access_token "5627g9nsurr6tm4"
    dropbox_access_secret "vv3uzfy578wkc6o"
    
    sync_dir '/Users/frank/Projects/insoftretail/old/audio_files'
    adv_blocks_dir 'adv_blocks'
    music_dir 'music'

    # Количество рекламных блоков в день
    blocks_count 4
    
    # Путь к созданному плейлисту
    playlist_path '/Users/frank/Projects/insoftretail/old/gradus_real_playlist.xspf'
    
    # Уникальные настройки для магазина
    shop do
      # адрес магазина (нужен для вывода в WEB-интерфейса)
      address 'Тестовый магазин'

      # название файла логов для этого магазина (желательно ввиде адреса магазина, транслитом, например: polbina_48.txt)
      log_filename 'test_shop.txt'
      
    end
  end
    # 
    # env :prod, parent: :dev do
    # end
    # 
    # env :test, parent: :dev do
    # end
end