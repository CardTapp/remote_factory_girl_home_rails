require "remote_factory_bot_home_rails/engine"

module RemoteFactoryBotHomeRails

  OFF = false
  ON  = true

  def self.skip_around_action
    filters = config.skip_around_action
    filters.present? ? [filters].flatten.map(&:to_sym) : nil
  end

  def self.skip_before_action
    filters = config.skip_before_action
    filters.present? ? [filters].flatten.map(&:to_sym) : nil
  end

  def autoload_factories
    config
  end

  def self.config(config = RemoteFactoryBotHomeRails::Engine.config.remote_factory_bot_home_rails)
    config.autoload_factories
  end

  def self.configure
    yield config
  end

  def self.enable!
    config.enable = ON
  end

  def self.disable!
    config.enable = OFF
  end

  def self.enabled?
    config.enable == ON
  end

  def self.reset
    config.enable = OFF
    config.skip_before_action = nil
    config.skip_around_action = nil
  end
end
