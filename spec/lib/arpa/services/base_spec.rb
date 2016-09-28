require 'spec_helper'

class CustomTransactionClass
  def self.transaction
    yield
  end
end

class ManagerImplementationTest
  include Arpa::Services::Base

  def create_raise callback
    manager_action callback do
      raise Exceptions::RecordInvalid.new 'some error'
    end
  end

  def create callback
    manager_action callback do
      'success'
    end
  end

end

describe Arpa::Services::Base, type: :service, fast: true do

  let(:manager_implementation) { ManagerImplementationTest.new }
  let(:callback) {
    {
      success: -> (result) {},
      fail: -> (exception){}
    }
  }

  describe 'calling .transaction' do
    before do
      set_custom_transaction_class
      allow(transaction_class).to receive(:transaction)
      manager_implementation.create callback
    end

    context 'when use the default transaction_class from Services::ManagerBase' do
      let(:set_custom_transaction_class) { manager_implementation.class.repository_transaction nil }
      let(:transaction_class)            { ActiveRecord::Base }

      it 'transaction_class should call .transaction' do
        expect(transaction_class).to have_received(:transaction)
      end

    end

    context 'when use a custom transaction_class' do
      let(:set_custom_transaction_class) { manager_implementation.class.repository_transaction 'CustomTransactionClass' }
      let(:transaction_class)            { CustomTransactionClass }

      it 'transaction_class should call .transaction' do
        expect(transaction_class).to have_received(:transaction)
      end

    end
  end

  describe 'calling correct callback' do
    before do
      manager_implementation.class.repository_transaction 'CustomTransactionClass'
    end

    context 'when success transaction' do
      before do
        allow(callback[:success]).to receive(:call)
        manager_implementation.create callback
      end

      it 'should call the callback[:success]' do
        expect(callback[:success]).to have_received(:call).once
      end
    end

    context 'when fail transaction' do
      before do
        allow(callback[:fail]).to receive(:call).with kind_of StandardError
        manager_implementation.create_raise callback
      end


      it 'should call the callback[:fail] with Exceptions::RecordInvalid' do
        expect(callback[:fail]).to have_received(:call).with(kind_of StandardError)
      end

    end
  end

end
