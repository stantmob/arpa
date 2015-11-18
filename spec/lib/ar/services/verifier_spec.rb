require 'spec_helper'

describe Ar::Services::Verifier do
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

  subject(:verifier) { Ar::Services::Verifier.new(session, current_user) }

  describe '#has_access?' do
    context 'when pass a free action which begin with "_"' do
      it 'should has access' do
        expect(subject.has_access?('home', '_some_action')).to be_truthy
      end
    end
    context 'when pass an existent controller and action' do
      it 'should has access' do
        expect(subject.has_access?('users', 'index')).to be_truthy
      end
    end

    context 'when not pass an existent controller and action' do
      it 'should has not access' do
        expect(subject.has_access?('home', 'index')).to be_falsey
      end
    end
  end
end
