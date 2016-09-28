require 'spec_helper'

class BaseImplementationTest
  include Arpa::Repositories::Base
end

describe Arpa::Repositories::Base, type: :repository, fast: true do

  let(:base_implementation) { BaseImplementationTest.new }

  context 'when Implementation class do not override methods from Base' do

    context 'when call :mapper_instance' do

      it 'should raise NotImplementedError' do
        expect { base_implementation.mapper_instance }.to raise_error do |error|
          expect(error).to be_a NotImplementedError
          expect(error.message).to eql 'This BaseImplementationTest cannot respond :mapper_instance'
        end
      end

    end

    context 'when call :repository_class' do

      it 'should raise NotImplementedError' do
        expect { base_implementation.repository_class}.to raise_error do |error|
          expect(error).to be_a NotImplementedError
          expect(error.message).to eql 'This BaseImplementationTest cannot respond :repository_class'
        end
      end

    end

  end

end
