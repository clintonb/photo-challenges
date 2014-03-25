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

  it 'has a lowercased email field' do
    email = Faker::Internet.email.upcase!
    user = create(:user, email: email)
    expect(user.email).to eq email.downcase
  end

  describe '#get_display_name' do
    context 'with display_name set' do
      let(:user) { build(:user, display_name: Faker::Name.name) }

      it 'returns display_name' do
        expect(user.get_display_name()).to eq user.display_name
      end
    end

    context 'without display_name set' do
      context 'without last_name set' do
        let(:user) { build(:user, display_name: nil, last_name: nil) }

        it 'returns first_name' do
          expect(user.get_display_name()).to eq user.first_name
        end
      end

      context 'with last_name set' do
        let(:user) { build(:user, display_name: nil, last_name: Faker::Name.last_name) }

        it 'returns "first_name last_name"' do
          expect(user.get_display_name()).to eq "#{user.first_name} #{user.last_name}"
        end
      end
    end
  end
end
