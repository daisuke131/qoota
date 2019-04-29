require "rails_helper"

RSpec.describe "Articles", type: :request do
  describe "GET /articles" do
    subject { get(articles_path) }
    before { create_list(:article, 3, user_id: user.id) }
    let(:user) { create(:user) }
    it "記事一覧を取得する" do
      subject
      res = JSON.parse(response.body)
      expect(res.count).to eq 3
      expect(res[0].keys).to eq ["id", "title", "body", "status", "user_id"]
      expect(response.status).to eq 200
    end
  end
end
