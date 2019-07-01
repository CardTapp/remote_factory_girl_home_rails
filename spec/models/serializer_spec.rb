require 'remote_factory_bot_home_rails/serializer.rb'

describe RemoteFactoryBotHomeRails::Serializer do

  subject { RemoteFactoryBotHomeRails::Serializer }
  let(:user) { double('User') }

  describe '.serialize' do
    it 'should return ' do
      expect(user).to receive(:attributes)
      subject.serialize(user)
    end
  end
end
