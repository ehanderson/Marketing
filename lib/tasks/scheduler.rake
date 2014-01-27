desc "This task is called by the Heroku scheduler add-on"
task :this_task => :environment do
  puts "Running checkins..."
    checkin_time = Time.now
    fake_token =  "CAAT4RXN1suYBACVEBCwmiIErrhUgBJZCWXO
                  ToGRdNdW9pzoHDEGipojrphl3XM3wJztdPJuIx
                  8xCvxmsVE3KNvfOT5uq1r9FWHRm1IeAknskUw9b
                  XWZCe46luE7oZBbFOLgPnvkUbLiktDXJsPh5nil
                  PwLNRSw5duBcbgWJwFgTBvDHI31V"
    Checkin.create_checkin(fake_token, checkin_time)
  puts "done."
end
