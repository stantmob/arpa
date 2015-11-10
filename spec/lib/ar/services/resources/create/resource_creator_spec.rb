require 'spec_helper'

describe Ar::Services::Resources::Create::ResourceCreator, type: :service, fast: true do

  let(:resource_entity_class) { Ar::Entities::Resource }
  let(:resource)              { double }
  let(:resourceable)          { double }

  let(:resource_created) { subject.create(resourceable) }
  let(:validator_class)  { Ar::Validators::ResourceValidator }
  let(:validator)        { instance_double validator_class }

  before do
    allow(validator_class).to receive(:new).with(resource).and_return(validator)
    allow(resource_entity_class).to receive(:new).and_return(resource)
    allow(resource).to receive(:build_correct_name)
  end

  describe 'creating a new resource' do

    context 'when resource is invalid' do
      let(:errors) { instance_double('ActiveModel::Errors') }

      before do
        allow(validator).to receive(:valid?).and_return false
        allow(validator).to receive(:errors).and_return(errors)
        allow(errors).to receive(:messages)
      end

      it 'should raise a Ar::Exceptions::RecordInvalid with :errors of ActiveModel::Errors' do
        expect { resource_created }.to raise_error { |error|
          expect(error).to be_a Ar::Exceptions::RecordInvalid
          expect(error.errors).not_to be_nil
        }
      end

    end

    context 'when resource is valid' do
      let(:creator_repo_class) { Ar::Repositories::Resources::Creator }
      let(:creator_repo)       { instance_double creator_repo_class }

      before do
        allow(validator).to receive(:valid?).and_return true
        allow(creator_repo_class).to receive(:new).and_return(creator_repo)
        allow(creator_repo).to receive(:create).with(resource)
        resource_created
      end

      it 'creator repository should call :new' do
        expect(creator_repo_class).to have_received(:new)
      end

      it 'creator_repo should call create method with resource as parameter' do
        expect(creator_repo).to have_received(:create).with(resource).once
      end

      context 'when build the resource with resourceable' do

        it 'entity resource should call new method' do
          expect(resource_entity_class).to have_received(:new).once
        end

        it 'resource instance should call build_correct_name method' do
          expect(resource).to have_received(:build_correct_name).once
        end
      end

    end

  end
end
