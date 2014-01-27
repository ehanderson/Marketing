desc "This task is called by the Heroku scheduler add-on"
task :this_task => :environment do
  puts "Running checkins..."
  # Checkin.perform

    checkin_time = Time.now
    oauth_token = "CAAT4RXN1suYBANj5Jz6dOvgRCxoPKZC2yDgebeMadOIJSQppB9bkVta0Ph0L8ZAP23DmR8T9IyihwEiGnEViPXAVytL8ZB5C6iu9wEsRwoYLxOfcpAEcRQBkk8T0nMZAD5Ulitk6ZCv7yq0PoZAY1xjWE39L6sdCk8N87DFAX3qqodMJsFhyFG"
    puts "this is my oauth token bitches"
    puts oauth_token

    Checkin.create_checkin(oauth_token, checkin_time)
    # end
  puts "done."
end
