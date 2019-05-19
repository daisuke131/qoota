require "rails_helper"

RSpec.describe "Api::V1::Users", type: :request do
  describe "GET /api/v1/users" do
    subject { get(api_v1_users_path) }
    before { create_list(:user, 3) }

    it "ユーザー一覧を取得する" do
      subject
      res = JSON.parse(response.body)
      expect(res.count).to eq 3
      expect(res[0].keys).to eq ["id","name", "email"]
      expect(response.status).to eq 200
    end
  end

  describe "GET /api/v1/users/:id" do
    subject { get(api_v1_user_path(user_id)) }
    let!(:user) { create(:user) }

    context "指定したidのユーザーが存在する場合" do
      let(:user_id) { user.id }

      it "ユーザーの値を取得する" do
        subject
        res = JSON.parse(response.body)
        expect(res["name"]).to eq user.name
        expect(res["email"]).to eq user.email
        expect(response).to have_http_status(200)
      end
    end

    context "指定したidのユーザーが存在しない場合" do
      let(:user_id) { 98765 }

      it "ユーザーが見つからない" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "PATCH /api/v1/users/:id" do
    subject { patch(api_v1_user_path(current_user.id), params: params, headers: auth_token(current_user)) }
    let(:current_user) { create(:user) }
    let(:params) { { user: { name: Faker::Name.name, created_at: Time.current } } }

    it "指定したユーザーのレコードが更新される" do
      expect { subject }.to change { User.find(current_user.id).name }.from(current_user.name).to(params[:user][:name])
      expect { subject }.not_to change { User.find(current_user.id).email }
      expect { subject }.not_to change { User.find(current_user.id).created_at }
      expect(response).to have_http_status(204)
    end
  end
end
