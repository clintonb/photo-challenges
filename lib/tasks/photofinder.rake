require 'tweetstream'

namespace :photofinder do
  desc 'Finds photos posted to Twitter'
  task twitter: :environment do
    logger = Rails.logger

    TweetStream.configure do |config|
      config.consumer_key = '9FO78MuKm6dCkFJ1zvgiQ'
      config.consumer_secret = 'neJtg0nxBLXE1dw1frV8vMmwvO8sVufl5B9txjam5hw'
      config.oauth_token = '43314773-vLB3f6GErHYKzS7XsF7hU3p7RzTAMaLanlU3atc06'
      config.oauth_token_secret = 'vblRtdj7qPcSi3w1XtXWKexobhDvhoZ5qzrd0DRA2dAFc'
      config.auth_method = :oauth
    end

    keywords = Challenge.hashtags
    logger.debug "Now tracking #{keywords.join(', ')}"

    client = TweetStream::Client.new
    client.on_inited do
      timer = EM::PeriodicTimer.new(20) do
        keywords = Challenge.hashtags
        client.stream.update(:params => {:track => keywords})
        logger.debug "Now tracking #{keywords.join(', ')}"
      end
    end

    client.track(keywords) do |tweet|
      begin
        if Helpers::Twitter::tweet_contains_hashtags?(tweet, *keywords)
          Helpers::Twitter::process_tweet(tweet)
        end
        tweeter = tweet.user
        logger.debug("#{tweeter.screen_name}(#{tweeter.id})\t#{tweet.id}\t#{tweet.text}")

      rescue Exception => e
        logger.error ("#{e}\n#{e.backtrace}")
      end
    end
  end
end
