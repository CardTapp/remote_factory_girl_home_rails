require 'spec_helper'

describe RemoteFactoryBotHomeRails::HomeController, type: :controller do

  routes { RemoteFactoryBotHomeRails::Engine.routes }

  describe '#create' do
    describe "when '.skip_before_action' methods are configured" do
      it 'should skip :authentication and :another_authentication methods defined in ApplicationController' do
        post :create, params: {'factory' => 'user', 'attributes' => {'first_name' => 'Sam'}}
        expect(response).to_not redirect_to('/401.html')
      end
    end

    describe "when '.skip_around_action' methods are configured" do
      it 'should skip :authentication and :around_test methods defined in ApplicationController' do
        post :create, params: {'factory' => 'user', 'attributes' => {'first_name' => 'Sam'}}
        expect(response).to_not redirect_to('/401.html')
      end
    end
    describe 'when enabled' do

      before { RemoteFactoryBotHomeRails.enable! }

      it 'should return status code 200' do
        post :create, params: {'factory' => 'user'}
        expect(response.status).to eq(200)
      end

      it 'should create a user resource with FactoryBot' do
        expect(FactoryBot).to receive(:create).with(:user, {}).and_return(User.create)
        post :create, params: {'factory' => 'user'}
      end
    end

    it 'should return status code 403 when RemoteFactoryBotHomeRails is not enabled' do
      post :create, params: {}
      expect(response.status).to eq(403)
    end
  end

  describe 'Returning all defined factories' do
    before do
      RemoteFactoryBotHomeRails.configure do |config|
        config.skip_before_action = [:authenticate, :another_authentication]
        config.enable = true
      end
    end

    it 'should return a list of available factories' do
      get :index
      expect(response_json(response.body)['factories']).to eq(['user'])
    end
  end

  describe 'Creating models remotely' do
    before do
      RemoteFactoryBotHomeRails.configure do |config|
        config.skip_before_action = [:authenticate, :another_authentication]
        config.enable = true
      end
    end

    it 'should return a JSON response' do
      post :create, params: {'factory' => 'user', 'attributes' => {'first_name' => 'Sam'}}
      puts response.body
      expect(response_json(response.body)['first_name']).to eq('Sam')
    end
  end
end

