# encoding: utf-8


Configus.build AudioClient::Application.env do
  env :dev, parent: :prod  do
    
    test_files_path = File.dirname(AudioClient::Application.base_path)
    
    timeout_before_sync 1
    sleeping_time_out 1
    
    #
    # Settings for afrank_test_app !!!
    #
    dropbox_app_key "o5y30tzpxbqmz7r"
    dropbox_app_secret "ilbq1j1xf5kbuyk"
    dropbox_app_mode "sandbox"
    dropbox_access_token "v1tg9ydu95pwndx"
    dropbox_access_secret "mahqjha3avfokt7"
    
    sync_dir "#{test_files_path}/dev_music"
    adv_blocks_dir 'adv_blocks'
    music_dir 'music'

    # Количество рекламных блоков в день
    blocks_count 4
    
    # Путь к созданному плейлисту
    playlist_path "#{test_files_path}/dev_playlist.xspf"
    
    # Уникальные настройки для магазина
    shop do
      # адрес магазина (нужен для вывода в WEB-интерфейса)
      address 'Тестовый магазин (режим разработки)'

      # название файла логов для этого магазина (желательно ввиде адреса магазина, транслитом, например: polbina_48.txt)
      log_filename 'test_shop_development.txt'
      
    end
  end
    
  env :prod do
    user_path = File.expand_path("~")
    
    timeout_before_sync 10
    sleeping_time_out 5
    
    dropbox_app_key "29sx8gw6l0b0nnv"
    dropbox_app_secret "i5ecioot61yszja"
    dropbox_app_mode "sandbox"
    dropbox_access_token "5627g9nsurr6tm4"
    dropbox_access_secret "vv3uzfy578wkc6o"
    
    sync_dir "#{user_path}/music"
    adv_blocks_dir 'adv_blocks'
    music_dir 'music'

    # Количество рекламных блоков в день
    blocks_count 4
    
    # Путь к созданному плейлисту
    playlist_path "#{user_path}/playlist.xspf"
    
    # Уникальные настройки для магазина
    shop do
      # адрес магазина (нужен для вывода в WEB-интерфейса)
      address 'Тестовый магазин'

      # название файла логов для этого магазина (желательно ввиде адреса магазина, транслитом, например: polbina_48.txt)
      log_filename 'test_shop.txt'
    end
  end
end
