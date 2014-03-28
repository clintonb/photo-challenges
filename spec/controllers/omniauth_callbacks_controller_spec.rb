require 'spec_helper'

describe OmniauthCallbacksController do
  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe :twitter do
    let!(:twitter_user_id) { Faker::Number.number(10) }

    before(:each) do
      request.env['omniauth.auth'] = {'provider' => 'twitter', 'uid' => twitter_user_id, 'credentials' => {'token' => '', 'token_secret' => ''}}
    end

    subject(:response) { get :twitter }


    context 'existing user' do
      let!(:user) { create(:user) }

      context 'logged in' do
        before(:each) do
          sign_in(:user, user)
        end

        it { should redirect_to root_path }

        context 'not authenticated' do
          it { should redirect_to root_path }

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
        it { should redirect_to root_path }
      end
    end

    context 'new user' do

    end
  end
end
