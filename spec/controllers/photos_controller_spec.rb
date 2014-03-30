require 'spec_helper'

describe PhotosController do

  describe 'GET index' do
    let!(:photos) { create_list(:photo, 5) }
    subject(:response) { get :index }

    it { should be_success }

    it 'assigns @photos' do
      response
      expect(assigns(:photos)).to match_array(photos)
    end
  end

  describe 'GET show' do
    let(:photo) { create(:photo) }
    subject(:response) { get :show, {:id => photo.to_param} }

    it { should be_success }

    it 'assigns @photo' do
      response
      expect(assigns(:photo)).to eq photo
    end
  end

  #describe 'DELETE destroy' do
  #  let!(:photo) { create(:photo) }
  #  subject(:response) { delete :destroy, {:id => photo.to_param} }
  #
  #  its(:status) { should redirect_to(new_user_session_path) }
  #
  #  context 'with an authenticated user' do
  #    include_context 'authenticated user'
  #
  #    let!(:photo) { create(:photo, user: user) }
  #
  #    it 'deletes the photo' do
  #      expect(Photo.count).to eq(1)
  #      response
  #      expect(Photo.count).to eq(0)
  #    end
  #
  #    it { should redirect_to(photos_url) }
  #  end
  #end
end
