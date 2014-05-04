module Services
  class TweetService
    def tweet_contains_hashtags?(tweet, *hashtags)
      if hashtags and tweet.hashtags.any?
        hashtags = hashtags.reject(&:blank?).map(&:downcase)
        tweet_tags = get_hashtags(tweet)
        return !(hashtags & tweet_tags).empty?
      end

      false
    end


    def process_tweet(tweet)
      logger = Rails.logger

      logger.debug "Processing tweet #{tweet.id}..."
      image_url = tweet_image_url(tweet)

      if image_url
        # Get Challenges from hashtags
        challenges = Challenge.find_by_hashtags(*get_hashtags(tweet))

        if challenges.size > 0
          # Get or create User
          user = User.find_or_create_from_tweet!(tweet)

          unless user
            logger.error "Failed to find or create user for tweet #{tweet.id} for Twitter user #{tweet.user.id_str}"
            return nil
          end

          logger.debug "Tweet #{tweet.id} is associated with User #{user.id}"

          # Create Photo and associate with User and Challenges
          photo = Photo.create(user: user, challenges: challenges, url: image_url, data_source: DataSource.where(name: 'Twitter').first, data_source_external_id: tweet.id)
          logger.debug "Created Photo #{photo.id} from tweet #{tweet.id}"

          return photo
        else
          logger.debug "Tweet #{tweet.id} is not associated with any Challenges. Moving on."
        end
      else
        logger.debug "Tweet #{tweet.id} has no media. Moving on."
      end

      nil
    end

    def tweet_image_url(tweet)
      if tweet.media.any?
        return tweet.media[0].media_url.to_s
      end

      nil
    end

    def get_hashtags(tweet)
      tweet.hashtags.map { |hashtag| hashtag.text.downcase }
    end
  end
end
