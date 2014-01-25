include Clockwork
require 'config/boot'
require 'config/environment'

# every(3.minutes, 'marketpoint.fetch') { Delayed::Job.enqueue MarketPointJob.new }

every(5.minutes, 'checkin.fetch',){Delayed::Job.enqueue Checkinclock.new}

# every(1.hour, 'checkin.fetch',){Delayed::Job.enqueue Checkinclock.new}

# Clockwork.every(30.minutes, 'myjob', :if => lambda {|t| t.day == 2})

