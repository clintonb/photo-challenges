require 'spec_helper'

describe ChallengesController do

  let(:valid_attributes) { attributes_for(:challenge) }

  describe 'GET index' do
    it 'assigns @challenges and @voted' do
      challenges = create_list(:challenge, 5)
      get :index
      assigns(:challenges).should eq(challenges)
      assigns(:voted).should match_array([])
    end

    context 'with an authenticated user' do
      include_context 'authenticated user'

      it 'assigns @voted with ids of challenges voted up by the current user' do
        challenges = create_list(:challenge, 5)
        challenge = challenges[0]
        challenge.liked_by user
        get :index

        assigns(:voted).should match_array([challenge.id])
      end
    end

  end

  describe 'GET show' do
    it 'assigns the requested challenge as @challenge' do
      challenge = create(:challenge)
      get :show, {:id => challenge.to_param}
      assigns(:challenge).should eq(challenge)
    end
  end

  describe 'GET new' do
    context 'without an authenticated user' do
      it 'will redirect to the sign in path' do
        get :new

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'with an authenticated user' do
      include_context 'authenticated user'

      it 'assigns a new challenge as @challenge' do
        get :new
        assigns(:challenge).should be_a_new(Challenge)
      end
    end
  end

  describe 'GET edit' do
    context 'with an authenticated user' do
      include_context 'authenticated user'

      it 'assigns the requested challenge as @challenge' do
        challenge = create(:challenge)
        get :edit, {:id => challenge.to_param}
        assigns(:challenge).should eq(challenge)
      end
    end
  end

  describe 'POST create' do
    context 'without an authenticated user' do
      it 'will redirect to the sign in path' do
        post :create, {:challenge => {}}

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'with an authenticated user' do
      include_context 'authenticated user'

      context 'with valid params' do
        it 'creates a new Challenge' do
          expect {
            post :create, {:challenge => valid_attributes}
          }.to change(Challenge, :count).by(1)
        end

        it 'assigns a newly created challenge as @challenge' do
          post :create, {:challenge => valid_attributes}
          assigns(:challenge).should be_a(Challenge)
          assigns(:challenge).should be_persisted
        end

        it 'redirects to the created challenge' do
          post :create, {:challenge => valid_attributes}
          response.should redirect_to(Challenge.last)
        end

        it 'assigns the current user as the user/owner of the newly created challenge' do
          post :create, {:challenge => valid_attributes}
          expect(assigns(:challenge).user).to eq user
        end
      end

      context 'with invalid params' do
        it 'raises a ParameterMissing error' do
          expect { post(:create, {:challenge => {}}) }.to raise_error ActionController::ParameterMissing
        end
      end
    end
  end

  describe 'PUT update' do
    context 'with an authenticated user' do
      include_context 'authenticated user'

      describe 'with valid params' do
        it 'updates the requested challenge' do
          challenge = create(:challenge)
          # Assuming there are no other challenges in the database, this
          # specifies that the Challenge created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          params = {'description' => 'params'}
          Challenge.any_instance.should_receive(:update).with(params)
          put :update, {:id => challenge.to_param, :challenge => params}
        end

        it 'assigns the requested challenge as @challenge' do
          challenge = create(:challenge)
          put :update, {:id => challenge.to_param, :challenge => valid_attributes}
          assigns(:challenge).should eq(challenge)
        end

        it 'redirects to the challenge' do
          challenge = create(:challenge)
          put :update, {:id => challenge.to_param, :challenge => valid_attributes}
          response.should redirect_to(challenge)
        end
      end

      describe 'with invalid params' do
        it 'assigns the challenge as @challenge' do
          challenge = create(:challenge)
          # Trigger the behavior that occurs when invalid params are submitted
          Challenge.any_instance.stub(:save).and_return(false)
          expect { put :update, {:id => challenge.to_param, :challenge => {}} }.to raise_error ActionController::ParameterMissing
        end
      end
    end
  end

  describe 'PUT vote' do
    let(:challenge) { create(:challenge) }
    subject(:response) { put :vote, {id: challenge.to_param, format: :json} }

    its(:status) { should eq 401 }

    context 'with an authenticated user' do
      include_context 'authenticated user'

      its(:status) { should eq 200 }
      its(:body) { should eq({msg: 'Vote registered'}.to_json) }

      it 'should register a vote for the user' do
        response

        expect(challenge.votes.up.by_type(User).voters.count).to eq(1)
        expect(challenge.votes.up.by_type(User).voters.first).to eq(user)
        expect(user.get_up_voted(Challenge).first).to eq(challenge)
      end

      it 'should register only one vote after successive calls' do
        response
        response = put :vote, {id: challenge.to_param, format: :json}

        expect(challenge.votes.up.by_type(User).voters.count).to eq(1)
        expect(response.body).to eq({msg: 'Already voted'}.to_json)
        expect(user.get_up_voted(Challenge).first).to eq(challenge)
      end
    end
  end

  #describe "DELETE destroy" do
  #  it "destroys the requested challenge" do
  #    challenge = create(:challenge)
  #    expect {
  #      delete :destroy, {:id => challenge.to_param}
  #    }.to change(Challenge, :count).by(-1)
  #  end
  #
  #  it "redirects to the challenges list" do
  #    challenge = create(:challenge)
  #    delete :destroy, {:id => challenge.to_param}
  #    response.should redirect_to(challenges_url)
  #  end
  #end

end
