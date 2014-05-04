require 'tweetstream'

namespace :photofinder do
  desc 'Finds photos posted to Twitter'
  task twitter: :environment do
    logger = Rails.logger

    keywords = Challenge.hashtags
    logger.debug "Now tracking #{keywords.join(', ')}"

    client = TweetStream::Client.new

    client.on_unauthorized do
      msg = 'An error occurred while connecting to Twitter!'
      logger.error msg
      fail msg
    end

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
