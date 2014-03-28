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

  describe '#display_name' do
    context 'with username set' do
      let(:user) { build(:user, username: Faker::Name.name) }

      it 'returns username' do
        expect(user.display_name).to eq user.username
      end
    end

    context 'without username set' do
      context 'without last_name set' do
        let(:user) { build(:user, username: nil, last_name: nil) }

        it 'returns first_name' do
          expect(user.display_name).to eq user.first_name
        end
      end

      context 'with last_name set' do
        let(:user) { build(:user, username: nil, last_name: Faker::Name.last_name) }

        it 'returns "first_name last_name"' do
          expect(user.display_name).to eq "#{user.first_name} #{user.last_name}"
        end
      end
    end
  end

  describe '#find_or_create_from_tweet!' do
    let(:twitter_user_id) { Faker::Number.number(10) }
    let(:name) { Faker::Name.name }
    let(:tweet) { Twitter::Tweet.new(:id => Faker::Number.number(10), :user => {:id => twitter_user_id, :id_str => twitter_user_id.to_s, :name => name}) }
    subject(:user) { User.find_or_create_from_tweet!(tweet) }

    it { should be_a(User) }
    its('authentications.first.uid') { should eq(twitter_user_id.to_s) }

    context 'non-existent user' do
      its(:first_name) { should eq(name) }
      its(:email) { should eq("#{twitter_user_id}@twitter.fake") }
    end

    context 'user exists' do
      let(:password) { 'password' }
      let!(:existing_user) do
        user = create(:authentication, uid: twitter_user_id).user
        user.encrypted_password = password
        user.save
        user
      end

      it { should eq(existing_user) }
      its(:encrypted_password) { should eq(password) }
    end
  end
end
