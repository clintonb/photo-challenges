class DailyChallengesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :latest]
  before_action :set_daily_challenge, only: [:show]

  def index
    @daily_challenges = DailyChallenge.all.includes(:user, :challenge)
  end

  def show
  end

  def latest
    @daily_challenge = DailyChallenge.includes(:user, :challenge).order('created_at DESC').first
    @challenge = @daily_challenge.challenge
  end

  private
  def set_daily_challenge
    @daily_challenge = DailyChallenge.includes(:user, :challenge).find(params[:id])
  end
end
