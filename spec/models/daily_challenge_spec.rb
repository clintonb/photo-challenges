require 'spec_helper'

describe DailyChallenge do
  it 'has a valid factory' do
    expect(create(:daily_challenge)).to be_valid
  end

  it 'is invalid without a challenge' do
    expect(build(:daily_challenge, challenge: nil)).to_not be_valid
  end
end
