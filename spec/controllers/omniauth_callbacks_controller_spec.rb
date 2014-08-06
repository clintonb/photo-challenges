require 'spec_helper'

describe OmniauthCallbacksController do
  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe :twitter do
    let!(:twitter_user_id) { Faker::Number.number(10) }
    let(:name) { Faker::Name.name }
    let(:username) { Faker::Internet.user_name }
    let(:auth_env) { {'provider' => 'twitter', 'uid' => twitter_user_id, 'credentials' => {'token' => '', 'token_secret' => ''}, 'extra' => {'raw_info' => {'name' => name, 'screen_name' => username}}} }

    before(:each) do
      request.env['omniauth.auth'] = auth_env
    end

    subject(:response) { get :twitter }


    context 'existing user' do
      let!(:user) { create(:user) }

      context 'logged in' do
        before(:each) do
          sign_in(:user, user)
        end

        it { should redirect_to '/' }

        context 'not authenticated' do
          it { should redirect_to '/' }

          it 'should add a twitter authentication for the user' do
            response
            authentications = user.authentications
            authentication = authentications.first

            expect(authentications.count).to eq 1
            expect(authentication.uid).to eq twitter_user_id
            expect(authentication.provider).to eq 'twitter'
          end

        end
      end

      context 'logged out but authenticated' do
        let!(:user) { create(:authentication, provider: 'twitter', uid: twitter_user_id).user }
        it { should redirect_to '/' }
      end
    end

    context 'new user' do
      it { should redirect_to new_user_registration_path }

      it 'should set session keys' do
        response

        expect(session[:omniauth]).to eq(auth_env.except('extra'))
        expect(session[:extra]).to eq({first_name: name, username: username})
      end
    end
  end
end
