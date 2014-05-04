require 'spec_helper'
require 'twitter'

describe Services::TweetService do
  subject(:tweet_service) { Services::TweetService.new }

  describe '#tweet_contains_hashtags?' do
    let(:hashtags_array) do
      [
        {
          :text => 'twitter',
          :indices => [10, 33],
        }, {
        :text => 'facebook',
        :indices => [0, 8],
      }
      ]
    end

    let(:tweet) { Twitter::Tweet.new(:id => 28_669_546_014, :entities => {:hashtags => hashtags_array}) }

    it 'returns false if hashtag is blank' do
      expect(tweet_service.tweet_contains_hashtags?(tweet, nil)).to be_false
      expect(tweet_service.tweet_contains_hashtags?(tweet, '')).to be_false
      expect(tweet_service.tweet_contains_hashtags?(tweet, ' ')).to be_false
    end

    it 'returns false if the tweet does not contain the given hashtag' do
      expect(tweet_service.tweet_contains_hashtags?(tweet, 'xxxxxxxx')).to be_false
    end

    it 'returns true if the tweet contains the hashtag' do
      expect(tweet_service.tweet_contains_hashtags?(tweet, 'twitter')).to be_true
    end

    it 'is case-insensitive' do
      expect(tweet_service.tweet_contains_hashtags?(tweet, 'tWitTeR')).to be_true
      expect(tweet_service.tweet_contains_hashtags?(tweet, 'FaCEBooK')).to be_true
    end

    it 'supports finding multiple hashtags' do
      expect(tweet_service.tweet_contains_hashtags?(tweet, 'twitter', 'facebook')).to be_true
    end
  end

  describe '#tweet_image_url' do

    let(:url) { tweet_service.tweet_image_url(Twitter::Tweet.new(:id => 28_669_546_014, :entities => entities)) }

    context 'tweet without photos' do
      let(:entities) { {} }

      it 'returns nil if tweet has no images' do
        expect(url).to be_nil
      end
    end

    context 'tweet with photos' do
      let(:entities) { {:media => [{:id => '1', :type => 'photo', :media_url => 'http://example.org'}]} }

      it 'returns first URL for tweet with images' do
        expect(url).to eq 'http://example.org'
      end
    end
  end

  describe '#get_hashtags' do
    let(:tweet) { Twitter::Tweet.new(:id => 28_669_546_014, :entities => {:hashtags => [{:text => 'Twitter', :indices => [10, 33]}, {:text => 'facebook', :indices => [0, 8]}]}) }
    it 'returns a lowercase array of hashtags in the tweet' do
      expect(tweet_service.get_hashtags(tweet)).to match_array %w(twitter facebook)
    end
  end

  describe '#process_tweet' do
    let!(:challenges) { create_list(:challenge, 5) }
    let(:hashtags_array) do
      [
        {
          :text => Challenge.first.hashtag,
          :indices => [10, 33],
        }, {
        :text => 'twitter',
        :indices => [0, 8],
      }
      ]
    end
    let(:media_url) { 'http://example.org' }
    let(:media_array) { [{:id => '1', :type => 'photo', :media_url => media_url}] }
    let(:twitter_user_id) { Faker::Number.number(10) }
    let(:name) { Faker::Name.name }
    let(:tweet) { Twitter::Tweet.new(:id => Faker::Number.number(10), :user => {:id => twitter_user_id, :id_str => twitter_user_id.to_s, :name => name}, :entities => {:hashtags => hashtags_array, :media => media_array}) }
    subject(:photo) { tweet_service.process_tweet(tweet) }

    context 'no hashtags' do
      let(:hashtags_array) { [] }

      it { should be_nil }
    end

    context 'no media' do
      let(:media_array) { [] }
      it { should be_nil }
    end

    it { should be_a(Photo) }
    its(:challenges) { should_not be_nil }
    its(:user) { should_not be_nil }
    its(:data_source) { should eq(DataSource.where(name: 'Twitter').first) }
    its(:data_source_external_id) { should eq(tweet.id) }

    context 'existing user' do
      let!(:existing_user) { create(:authentication, provider: 'twitter', uid: twitter_user_id).user }

      its(:user) { should eq(existing_user) }
    end
  end
end
