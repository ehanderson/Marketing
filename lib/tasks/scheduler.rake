desc "This task is called by the Heroku scheduler add-on"
task :this_task => :environment do
  puts "Running checkins..."
    checkin_time = Time.now
    fake_token = FAKE_TOKEN
    Checkin.create_checkin(fake_token, checkin_time)
  puts "done."
end
