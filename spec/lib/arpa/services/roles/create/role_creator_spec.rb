require 'spec_helper'

describe Arpa::Services::Roles::Create::RoleCreator, type: :service, fast: true do

  let(:role_entity_class) { Arpa::Entities::Role }
  let(:role)              { double }
  let(:params)            { double }

  let(:role_created) { subject.create(params) }
  let(:validator_class)  { Arpa::Validators::RoleValidator }
  let(:validator)        { instance_double validator_class }

  before do
    allow(validator_class).to receive(:new).and_return(validator)
    allow(role_entity_class).to receive(:new).and_return(role)
  end

  describe 'creating a new role' do

    context 'when role is invalid' do
      let(:errors) { instance_double('ActiveModel::Errors') }

      before do
        allow(validator).to receive(:valid?).and_return false
        allow(validator).to receive(:errors).and_return(errors)
        allow(errors).to receive(:messages)
      end

      it 'should raise a Arpa::Exceptions::RecordInvalid with :errors of ActiveModel::Errors' do
        expect { role_created }.to raise_error { |error|
          expect(error).to be_a Arpa::Exceptions::RecordInvalid
          expect(error.errors).not_to be_nil
        }
      end

    end

    context 'when role is valid' do
      let(:creator_repo_class) { Arpa::Repositories::Roles::Creator }
      let(:creator_repo)       { instance_double creator_repo_class }

      before do
        allow(validator).to receive(:valid?).and_return true
        allow(creator_repo_class).to receive(:new).and_return(creator_repo)
        allow(creator_repo).to receive(:create).with(role)
        role_created
      end

      it 'creator repository should call :new' do
        expect(creator_repo_class).to have_received(:new)
      end

      it 'creator_repo should call create method with role as parameter' do
        expect(creator_repo).to have_received(:create).with(role).once
      end

      context 'when build the role' do

        it 'entity role should call new method' do
          expect(role_entity_class).to have_received(:new).once
        end

      end

    end

  end
end
