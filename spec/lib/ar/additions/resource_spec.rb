require 'spec_helper'

class ResourceImplementation
  def self.helper_method(args);end
  include Ar::Additions::Resource
  def session;'';end
  def current_user;'';end
end

describe Ar::Additions::Resource, type: :addition, fast: true do

  let(:resource_implementation) { ResourceImplementation.new }

  describe '#has_access?' do
    let(:verifier) { double }
    let(:resource) { double }
    let(:action)   { double }

    before do
      allow(Ar::Services::Verifier).to receive(:new).and_return(verifier)
      allow(verifier).to receive(:has_access?)
      resource_implementation.has_access?(resource, action)
    end

    it 'should call :new from Ar::Services::Verifier' do
      expect(Ar::Services::Verifier).to have_received(:new).once
    end

    it 'verifier should call :has_access? with resource and action as parameter' do
      expect(verifier).to have_received(:has_access?).with(resource, action).once
    end
  end

end
