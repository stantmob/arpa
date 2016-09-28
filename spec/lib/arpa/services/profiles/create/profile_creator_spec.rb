require 'spec_helper'

describe Arpa::Services::Profiles::Create::ProfileCreator, type: :service, fast: true do

  let(:profile_entity_class) { Arpa::Entities::Profile }
  let(:profile)              { double }
  let(:params)               { double }

  let(:profile_created)  { subject.create(params) }
  let(:validator_class)  { Arpa::Validators::ProfileValidator }
  let(:validator)        { instance_double validator_class }

  before do
    allow(validator_class).to receive(:new).and_return(validator)
    allow(profile_entity_class).to receive(:new).and_return(profile)
  end

  describe 'creating a new profile' do

    context 'when profile is invalid' do
      let(:errors) { instance_double('ActiveModel::Errors') }

      before do
        allow(validator).to receive(:valid?).and_return false
        allow(validator).to receive(:errors).and_return(errors)
        allow(errors).to receive(:messages)
      end

      it 'should raise a Arpa::Exceptions::RecordInvalid with :errors of ActiveModel::Errors' do
        expect { profile_created }.to raise_error { |error|
          expect(error).to be_a Arpa::Exceptions::RecordInvalid
          expect(error.errors).not_to be_nil
        }
      end

    end

    context 'when profile is valid' do
      let(:creator_repo_class) { Arpa::Repositories::Profiles::Creator }
      let(:creator_repo)       { instance_double creator_repo_class }

      before do
        allow(validator).to receive(:valid?).and_return true
        allow(creator_repo_class).to receive(:new).and_return(creator_repo)
        allow(creator_repo).to receive(:create).with(profile)
        profile_created
      end

      it 'creator repository should call :new' do
        expect(creator_repo_class).to have_received(:new)
      end

      it 'creator_repo should call create method with profile as parameter' do
        expect(creator_repo).to have_received(:create).with(profile).once
      end

      context 'when build the profile' do

        it 'entity profile should call new method' do
          expect(profile_entity_class).to have_received(:new).once
        end

      end

    end

  end
end
