require 'spec_helper'

describe DataSource do
  it 'has a valid factory' do
    expect(create(:data_source)).to be_valid
  end

  it 'is invalid without a name' do
    expect(build(:data_source, name: nil)).to_not be_valid
    expect(build(:data_source, name: '')).to_not be_valid
  end
end
