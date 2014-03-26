shared_context 'authenticated user' do
  let(:user) { create(:user) }

  before(:each) do
    sign_in(:user, user)
  end
end
