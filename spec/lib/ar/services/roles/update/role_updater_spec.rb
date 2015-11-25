require 'spec_helper'

describe Arpa::Services::Roles::Update::RoleUpdater, type: :service, fast: true do

  let(:role_entity_class) { Arpa::Entities::Role }
  let(:role)              { double }
  let(:params)            { double }

  let(:role_updated)    { subject.update(params) }
  let(:validator_class) { Arpa::Validators::RoleValidator }
  let(:validator)       { instance_double validator_class }

  before do
    allow(validator_class).to receive(:new).and_return(validator)
    allow(role_entity_class).to receive(:new).and_return(role)
  end

  describe 'updating a role' do

    context 'when role is invalid' do
      let(:errors) { instance_double('ActiveModel::Errors') }

      before do
        allow(validator).to receive(:valid?).and_return false
        allow(validator).to receive(:errors).and_return(errors)
        allow(errors).to receive(:messages)
      end

      it 'should raise a Arpa::Exceptions::RecordInvalid with :errors of ActiveModel::Errors' do
        expect { role_updated }.to raise_error { |error|
          expect(error).to be_a Arpa::Exceptions::RecordInvalid
          expect(error.errors).not_to be_nil
        }
      end

    end

    context 'when role is valid' do
      let(:updater_repo_class) { Arpa::Repositories::Roles::Updater }
      let(:updater_repo)       { instance_double updater_repo_class }

      before do
        allow(validator).to receive(:valid?).and_return true
        allow(updater_repo_class).to receive(:new).and_return(updater_repo)
        allow(updater_repo).to receive(:update).with(role)
        role_updated
      end

      it 'updater repository should call :new' do
        expect(updater_repo_class).to have_received(:new)
      end

      it 'updater_repo should call update method with role as parameter' do
        expect(updater_repo).to have_received(:update).with(role).once
      end

      context 'when build the role' do

        it 'entity role should call new method' do
          expect(role_entity_class).to have_received(:new).once
        end

      end

    end

  end
end
