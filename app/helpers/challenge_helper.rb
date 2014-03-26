module ChallengeHelper
  def challenge_editable(challenge)
    current_user and (challenge.user == current_user)
  end
end
