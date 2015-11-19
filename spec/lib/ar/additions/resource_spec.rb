require 'spec_helper'

class ResourceImplementation
  def self.helper_method(args);end
  include Ar::Additions::Resource
end

class CompleteResourceImplementation
  def self.helper_method(args);end
  include Ar::Additions::Resource
  def session
  end
  def current_user
  end
end

describe Ar::Additions::Resource, type: :addition, fast: true do

  let(:resource_implementation) { ResourceImplementation.new }

  context 'when Implementation class do not override methods from Ar::Additions::Resource' do

    context 'when call :session' do

      it 'should raise NotImplementedError' do
        expect { resource_implementation.session}.to raise_error do |error|
          expect(error).to be_a NotImplementedError
          expect(error.message).to eql 'This ResourceImplementation cannot respond :session'
        end
      end

    end

    context 'when call :current_user' do

      it 'should raise NotImplementedError' do
        expect { resource_implementation.current_user}.to raise_error do |error|
          expect(error).to be_a NotImplementedError
          expect(error.message).to eql 'This ResourceImplementation cannot respond :current_user'
        end
      end

    end

  end

  describe '#has_access?' do
    let(:resource_implementation) { CompleteResourceImplementation.new }
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
