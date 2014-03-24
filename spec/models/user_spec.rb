require 'spec_helper'

describe User do
  it 'has a valid factory' do
    expect(create(:user)).to be_valid
  end

  it 'is invalid without an email' do
    expect(build(:user, email: nil)).to_not be_valid
    expect(build(:user, email: '')).to_not be_valid
  end

  it 'is invalid without a first name' do
    expect(build(:user, first_name: nil)).to_not be_valid
    expect(build(:user, first_name: '')).to_not be_valid
  end
end
