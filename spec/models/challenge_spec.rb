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
end
