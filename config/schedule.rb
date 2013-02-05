# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

app_dir_path = File.dirname(File.dirname(File.expand_path(__FILE__)))

# set :output, "#{app_dir_path}/logs/cron.log"
# env :PATH, "#{ENV['PATH']}:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"

every :reboot do
  command "cd #{app_dir_path} && ./script/client.sh"
end

every 1.minute do # Many shortcuts available: :hour, :day, :month, :year, :reboot
  command "cd #{app_dir_path} && ./script/client.sh"
end

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
