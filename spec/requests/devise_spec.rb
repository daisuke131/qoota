require 'rails_helper'

RSpec.describe "Devise", type: :request do
  describe "POST /api/v1/auth" do
    subject { post(api_v1_user_registration_path, params: params) }
    let(:params) { attributes_for(:user) }

    it "sign upする" do
      expect { subject }.to change { User.count }.by(1)
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /api/v1/auth/sign_in" do
    let(:user) { create(:user) }
    let(:params) { { email: user.email, password: user.password } }
    subject { post(api_v1_user_session_path, params: params) }

    fit "ログインする" do
      subject
      expect(response).to have_http_status(200)
    end
  end

  describe "DELETE /api/v1/auth/sign_out" do
    let(:user) { create(:user) }
    let(:params) { { email: user.email, password: user.password } }
    subject { post(api_v1_user_session_path, params: params) }

    it "ログアウトする" do
      # binding.pry
      # subject
      # expect(response).to have_http_status(200)
      # response["access-token"]
      # response["client"]
      # response["uid"]
    end
  end

end
