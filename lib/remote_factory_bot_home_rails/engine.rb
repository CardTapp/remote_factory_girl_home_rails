module RemoteFactoryBotHomeRails
  class Engine < ::Rails::Engine
    isolate_namespace RemoteFactoryBotHomeRails

    config.generators do |g|
      g.test_framework :rspec, :fixture => false
      g.assets false
      g.helper false
    end

    config.remote_factory_bot_home_rails = ActiveSupport::OrderedOptions.new

    initializer "remote_factory_bot_home_rails.environment" do |app|
      options = app.config.remote_factory_bot_home_rails
      options.skip_before_action ||= nil
      options.skip_around_action ||= nil
      options.enable ||= false
    end
  end
end
