require 'spec_helper'

describe Ar::Additions::Resource, type: :additions, fast: true do

  context 'when it is include in some ModelClass' do
    let(:session) { {} }
    let(:current_user) {
      double(
        :user,
        user_permissions:
        [
          {"controller" => "users", "action" => "index"},
          {"controller" => "users", "action" => "show"},
          {"controller" => "users", "action" => "new"},
          {"controller" => "users", "action" => "edit"},
          {"controller" => "users", "action" => "create"}
        ]
      )
    }

    let(:application_controller) { Class.new }

    before do
      allow(Ar::Additions::Resource).to receive(:included)
      application_controller.class.send(:include, Ar::Additions::Resource)
      allow(application_controller).to receive(:session).and_return(session)
      allow(application_controller).to receive(:current_user).and_return(current_user)
    end

    describe '#has_access?' do

      context 'when pass a free action which begin with "_"' do

        it 'should has access' do
          expect(application_controller.has_access?('home', '_some_action')).to be_truthy
        end

      end

      context 'when pass an existent controller and action' do

        it 'should has access' do
          expect(application_controller.has_access?('users', 'index')).to be_truthy
        end

      end

     context 'when not pass an existent controller and action' do

        it 'should has not access' do
          expect(application_controller.has_access?('home', 'index')).to be_falsey
        end

      end

    end

  end

end
