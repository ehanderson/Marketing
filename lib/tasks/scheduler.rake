desc "This task is called by the Heroku scheduler add-on"
task :this_task => :environment do
  puts "Running checkins..."
    checkin_time = Time.now
    oauth_token = current_user.oauth_token
    Checkin.create_checkin(oauth_token, checkin_time)
    end
  puts "done."
end
