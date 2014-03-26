require 'spec_helper'

describe ChallengeHelper do
  describe '#challenge_editable' do
    let(:challenge) { create(:challenge) }

    context 'without an authenticated user' do
      it 'returns false' do
        expect(helper.challenge_editable(challenge)).to be_false
      end
    end

    context 'with an authenticated user' do
      include_context 'authenticated user'

      it 'returns false if the current user is not the owner of the challenge' do
        expect(challenge.user).to_not eq user
        expect(helper.challenge_editable(challenge)).to be_false
      end

      it 'returns true if the current user is the owner of the challenge' do
        challenge.user = user
        challenge.save()

        expect(challenge.user).to eq user
        expect(helper.challenge_editable(challenge)).to be_true
      end
    end
  end
end
