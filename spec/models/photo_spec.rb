require 'spec_helper'

describe Photo do
  it 'has a valid factory' do
    expect(create(:photo)).to be_valid
  end

  it 'is invalid without a challenge' do
    expect(build(:photo, challenge: nil)).to_not be_valid
  end

  it 'is invalid without a user' do
    expect(build(:photo, user: nil)).to_not be_valid
  end

  it 'is invalid without a url' do
    expect(build(:photo, url: nil)).to_not be_valid
    expect(build(:photo, url: '')).to_not be_valid
  end
end
