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

  describe "GET /articles/:id" do
    subject { get(article_path(article_id)) }

    context "指定したidの記事が存在する場合" do
      let(:user) { create(:user) }
      let(:article) { create(:article, user_id: user.id) }
      let(:article_id) { article.id }

      it "記事の値を取得する" do
        subject
        res = JSON.parse(response.body)
        expect(res["title"]).to eq article.title
        expect(res["body"]).to eq article.body
        expect(res["status"]).to eq article.status
        expect(res["user_id"]).to eq article.user_id
        expect(response.status).to eq 200
      end
    end

    context "指定したidの記事が存在しない場合" do
      let(:article_id) { 98765 }

      it "記事が見つからない" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end