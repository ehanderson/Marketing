desc "This task is called by the Heroku scheduler add-on"
task :this_task => :environment do
  puts "Running checkins..."
  Checkin.perform
  # curl -L -s http://localhost:3000/new/?refresh
  # @brands = Brand.first(2)
    # checkin = Time.now
# puts checkin
  #   @brands.each do |brand|
  #     facebook_link = brand.facebook_link
  #     youtubeteaser_link = brand.youtubeteaser_link
  #     topsy_link = brand.topsy_link
      # Checkin.data_lookup( topsy_link, youtubeteaser_link, facebook_link, brand.id, checkin)
  puts "done."
    # end
end
