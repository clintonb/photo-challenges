require 'spec_helper'

describe UsersController do

  describe 'GET show' do
    let!(:user) { create(:user) }

    let(:id) { user.id }

    subject do
      get :show, {:id => id}
      assigns(:user)
    end

    it { should eq user }

    context 'username param' do
      let(:id) { user.username }
      it { should eq user }
    end
  end
end
