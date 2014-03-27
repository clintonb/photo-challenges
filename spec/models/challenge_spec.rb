require 'spec_helper'

describe Challenge do
  it 'has a valid factory' do
    expect(create(:challenge)).to be_valid
  end

  it 'is invalid without a description' do
    expect(build(:challenge, description: nil)).to_not be_valid
    expect(build(:challenge, description: '')).to_not be_valid
  end

  it 'is invalid without a user' do
    expect(build(:challenge, user: nil)).to_not be_valid
  end

  describe '#hashtag' do
    subject(:challenge) {create(:challenge)}

    it 'returns a hashtag string' do
      expect(challenge.hashtag).to eq "pc#{challenge.id}"
    end
  end

  describe '#hashtags' do
    let!(:challenges) { create_list(:challenge, 5) }

    it 'returns a list containing one hashtag per challenge' do
      expect(Challenge.count).to eq 5
      expect(Challenge.hashtags).to match_array(challenges.map(&:hashtag))
    end
  end

  describe '#find_by_hashtags' do
    let!(:challenges) { create_list(:challenge, 5) }

    it 'returns a list of Challenges matching the hashtags' do
      hashtags = Challenge.hashtags
      expect(Challenge.find_by_hashtags(*hashtags)).to match_array(challenges)
    end
  end
end
