require 'remote_factory_bot_home_rails/serializer'
require 'factory_bot'

module RemoteFactoryBotHomeRails
  class HomeController < ApplicationController

    skip_before_action *RemoteFactoryBotHomeRails.skip_before_action
    skip_around_action *RemoteFactoryBotHomeRails.skip_around_action

    before_action :load_factories

    def create
      if RemoteFactoryBotHomeRails.enabled?
        resource = traits.empty? ? FactoryBot.create(factory, attributes) : FactoryBot.create(factory, *traits, attributes)
        render json: Serializer.serialize(resource)
      else
        forbidden = 403
        render json: { status: forbidden }, status: forbidden
      end
    end

    def index
      factories = FactoryBot.factories.map(&:name)
      render json: { factories: factories }
    end

    private

    def factory
      params['factory'].to_sym
    end

    def attributes
      attrs = (params['attributes'] || {'traits' => []})
      attrs.delete('traits')
      attrs.to_enum.to_h
    end

    def traits
      attributes['traits'] || []
    end

    def load_factories
      return if @factories_loaded || Rails.env.test?

      self.class.find_definitions
      @factories_loaded = true
    end

    def self.find_definitions
    definition_file_paths = %w(factories test/factories spec/factories)
      absolute_definition_file_paths = definition_file_paths.map { |path| File.join(Rails.root, path) }

      absolute_definition_file_paths.uniq.each do |path|
        load("#{path}.rb") if File.exist?("#{path}.rb")

        if File.directory? path
          Dir[File.join(path, "**", "*.rb")].sort.each do |file|
            load file
          end
        end
      end
    end
  end
end
