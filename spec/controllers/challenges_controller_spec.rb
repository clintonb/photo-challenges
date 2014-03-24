require 'spec_helper'

describe ChallengesController do

  let(:valid_attributes) { attributes_for(:challenge) }

  describe 'GET index' do
    it 'assigns all challenges as @challenges' do
      challenges = create_list(:challenge, 5)
      get :index
      assigns(:challenges).should eq(challenges)
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
      before(:each) do
        sign_in(:user, create(:user))
      end

      it 'assigns a new challenge as @challenge' do
        get :new
        assigns(:challenge).should be_a_new(Challenge)
      end
    end
  end

  #describe "GET edit" do
  #  it "assigns the requested challenge as @challenge" do
  #    challenge = create(:challenge)
  #    get :edit, {:id => challenge.to_param}
  #    assigns(:challenge).should eq(challenge)
  #  end
  #end

  describe 'POST create' do
    context 'without an authenticated user' do
      it 'will redirect to the sign in path' do
        post :create, {:challenge => {}}

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'with an authenticated user' do
      let(:user) { create(:user) }

      before(:each) do
        sign_in(:user, user)
      end

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
          expect{ post(:create, {:challenge => {}}) }.to raise_error ActionController::ParameterMissing
        end
      end
    end
  end

  #describe "PUT update" do
  #  describe "with valid params" do
  #    it "updates the requested challenge" do
  #      challenge = create(:challenge)
  #      # Assuming there are no other challenges in the database, this
  #      # specifies that the Challenge created on the previous line
  #      # receives the :update_attributes message with whatever params are
  #      # submitted in the request.
  #      Challenge.any_instance.should_receive(:update).with({ "these" => "params" })
  #      put :update, {:id => challenge.to_param, :challenge => { "these" => "params" }}
  #    end
  #
  #    it "assigns the requested challenge as @challenge" do
  #      challenge = create(:challenge)
  #      put :update, {:id => challenge.to_param, :challenge => valid_attributes}
  #      assigns(:challenge).should eq(challenge)
  #    end
  #
  #    it "redirects to the challenge" do
  #      challenge = create(:challenge)
  #      put :update, {:id => challenge.to_param, :challenge => valid_attributes}
  #      response.should redirect_to(challenge)
  #    end
  #  end
  #
  #  describe "with invalid params" do
  #    it "assigns the challenge as @challenge" do
  #      challenge = create(:challenge)
  #      # Trigger the behavior that occurs when invalid params are submitted
  #      Challenge.any_instance.stub(:save).and_return(false)
  #      put :update, {:id => challenge.to_param, :challenge => {  }}
  #      assigns(:challenge).should eq(challenge)
  #    end
  #
  #    it "re-renders the 'edit' template" do
  #      challenge = create(:challenge)
  #      # Trigger the behavior that occurs when invalid params are submitted
  #      Challenge.any_instance.stub(:save).and_return(false)
  #      put :update, {:id => challenge.to_param, :challenge => {  }}
  #      response.should render_template("edit")
  #    end
  #  end
  #end
  #
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
