require 'remote_factory_bot_home_rails/serializer'

module RemoteFactoryBotHomeRails
  class HomeController < ApplicationController

    skip_before_action *RemoteFactoryBotHomeRails.skip_before_action
    skip_around_action *RemoteFactoryBotHomeRails.skip_around_action

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
  end
end
