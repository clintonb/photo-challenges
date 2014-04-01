require 'spec_helper'

describe DailyChallengesController do

  describe 'GET index' do
    let!(:daily_challenges) { create_list(:daily_challenge, 5) }

    it 'returns http success' do
      get :index
      response.should be_success
    end

    it 'assigns @daily_challenges' do
      get :index
      expect(assigns(:daily_challenges)).to match_array(daily_challenges)
    end
  end

  describe 'GET show' do
    let!(:daily_challenge) { create(:daily_challenge) }

    it 'returns http success' do
      get :show, {:id => daily_challenge.to_param}
      response.should be_success
    end

    it 'assigns @daily_challenge' do
      get :show, {:id => daily_challenge.to_param}
      expect(assigns(:daily_challenge)).to eq(daily_challenge)
    end
  end

  describe 'GET latest' do
    let!(:daily_challenges) { create_list(:daily_challenge, 5) }

    it 'assigns the most recent DailyChallenge to @daily_challenge' do
      get :latest
      expect(assigns(:daily_challenge)).to eq(daily_challenges[4])
    end
  end
end
