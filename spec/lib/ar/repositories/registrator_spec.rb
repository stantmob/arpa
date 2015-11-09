require 'spec_helper'

class RegistratorImplementationTest
  include Ar::Repositories::Registrator

  def mapper_class
  end

  def repository_class
  end

end

describe Ar::Repositories::Registrator, type: :repository, fast: true do

  let(:mapper_class)               { double }
  let(:repository_class)           { double }
  let(:registrator_implementation) { RegistratorImplementationTest.new }

  let(:entity) { double }
  let(:record) { double(:model, errors: double(:errors, full_messages: [])) }

  before do
    allow(registrator_implementation).to receive(:mapper_class).and_return(mapper_class)
    allow(registrator_implementation).to receive(:repository_class).and_return(repository_class)

    allow(mapper_class).to receive(:map_to_record).with(repository_class, entity).and_return(record)
  end

  describe 'creating a new RegistratorImplementation' do

    context 'when success' do

      before do
        allow(record).to receive(:save!).and_return(record)
        allow(mapper_class).to receive(:map_to_entity).with(record, entity)
        registrator_implementation.create(entity)
      end

      it 'mapper_class should call the :map_to_entity once with the saved record and the entity' do
        expect(mapper_class).to have_received(:map_to_entity).with(record, entity).once
      end
    end

    context 'when fail' do

      before do
        allow(RSpec::Mocks::Double).to receive(:i18n_scope)
        allow(record).to receive(:save!).and_raise(ActiveRecord::RecordInvalid.new(record))
      end

      it 'should raise a Ar::Exceptions::RecordInvalid with :errors of ActiveModel::Errors' do

        expect { registrator_implementation.create(entity) }.to raise_error { |error|
          expect(error).to be_a Ar::Exceptions::RecordInvalid
          expect(error.errors).not_to be_nil
        }
      end

    end

  end

end
