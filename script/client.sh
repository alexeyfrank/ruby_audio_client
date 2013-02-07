#!/bin/bash

current_path=`pwd`

export DISPLAY=:0.0

gnome-terminal -e "$current_path/script/run prod"

# # $KCODE='u'
# 
# cd /Users/frank/Projects/insoftretail/old/audio_client/
# bundle exec ruby ./file_updater/cron.rb -Ku
# 
# cd ../playlist_creator/
# ruby /Users/frank/Projects/insoftretail/old/audio_client/playlist_creator/build_playlist.rb
# 
# cd ../music_player
# ruby /Users/frank/Projects/insoftretail/old/audio_client/music_player/player.rb
