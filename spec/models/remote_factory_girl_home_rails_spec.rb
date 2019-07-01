require 'spec_helper'

describe RemoteFactoryBotHomeRails do

  describe '.enable!' do
    it 'should return true when enabled' do
      RemoteFactoryBotHomeRails.enable!
      expect(RemoteFactoryBotHomeRails.enabled?).to be_truthy
    end
  end

  describe '.enabled?' do
    it 'should return false when disabled' do
      expect(RemoteFactoryBotHomeRails.enabled?).to be_falsey
    end
  end

  describe '.disable!' do
    it 'should disable' do
      RemoteFactoryBotHomeRails.enable!
      RemoteFactoryBotHomeRails.disable!
      expect(RemoteFactoryBotHomeRails.enabled?).to be_falsey
    end
  end
end
