require 'spec_helper'

describe Photo do
  it 'has a valid factory' do
    photo = create(:photo)
    expect(photo.challenges.count).to be > 0
    expect(photo).to be_valid
  end

  it 'is invalid without a challenge' do
    photo = build(:photo)
    expect(photo.challenges.count).to eq 0
    expect(photo).to_not be_valid
  end

  it 'is invalid without a user' do
    expect(build(:photo, user: nil)).to_not be_valid
  end

  it 'is invalid without a url' do
    expect(build(:photo, url: nil)).to_not be_valid
    expect(build(:photo, url: '')).to_not be_valid
  end
end
