RemoteFactoryGirlHomeRails.configure do |config|
  config.skip_before_filter = [:authenticate, :another_authentication]
  config.skip_around_filter = [:test1, :test2]
end
