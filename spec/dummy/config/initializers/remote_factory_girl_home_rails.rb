RemoteFactoryBotHomeRails.configure do |config|
  config.skip_before_action = [:authenticate, :another_authentication]
  config.skip_around_action = [:around_test1, :around_test2]
end
