desc "This task is called by the Heroku scheduler add-on"
task :this_task => :environment do
  puts "Running checkins..."
  @brands = Brand.all
    checkin = Time.now

    @brands.each do |brand|
      facebook_link = brand.facebook_link
      youtubeteaser_link = brand.youtubeteaser_link
      topsy_link = brand.topsy_link
      Checkin.data_lookup(topsy_link, youtubeteaser_link, facebook_link, brand.id, checkin)
  puts "done."
    # end
end
