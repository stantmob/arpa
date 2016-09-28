require 'spec_helper'

describe Arpa::Services::Profiles::Update::ProfileUpdater, type: :service, fast: true do

  let(:role_entity_class) { Arpa::Entities::Profile }
  let(:profile)           { double }
  let(:params)            { double }

  let(:profile_updated) { subject.update(params) }
  let(:validator_class) { Arpa::Validators::ProfileValidator }
  let(:validator)       { instance_double validator_class }

  before do
    allow(validator_class).to receive(:new).and_return(validator)
    allow(role_entity_class).to receive(:new).and_return(profile)
  end

  describe 'updating a profile' do

    context 'when profile is invalid' do
      let(:errors) { instance_double('ActiveModel::Errors') }

      before do
        allow(validator).to receive(:valid?).and_return false
        allow(validator).to receive(:errors).and_return(errors)
        allow(errors).to receive(:messages)
      end

      it 'should raise a Arpa::Exceptions::RecordInvalid with :errors of ActiveModel::Errors' do
        expect { profile_updated }.to raise_error { |error|
          expect(error).to be_a Arpa::Exceptions::RecordInvalid
          expect(error.errors).not_to be_nil
        }
      end

    end

    context 'when profile is valid' do
      let(:updater_repo_class) { Arpa::Repositories::Profiles::Updater }
      let(:updater_repo)       { instance_double updater_repo_class }

      before do
        allow(validator).to receive(:valid?).and_return true
        allow(updater_repo_class).to receive(:new).and_return(updater_repo)
        allow(updater_repo).to receive(:update).with(profile)
        profile_updated
      end

      it 'updater repository should call :new' do
        expect(updater_repo_class).to have_received(:new)
      end

      it 'updater_repo should call update method with profile as parameter' do
        expect(updater_repo).to have_received(:update).with(profile).once
      end

      context 'when build the profile' do

        it 'entity profile should call new method' do
          expect(role_entity_class).to have_received(:new).once
        end

      end

    end

  end
end
