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
        expect(response).to have_http_status(200)
      end
    end

    context "指定したidの記事が存在しない場合" do
      let(:article_id) { 98765 }

      it "記事が見つからない" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "POST /articles" do
    subject { post(articles_path, params: params) }
    let(:current_user) { create(:user) }
    let(:params) { { article: attributes_for(:article, user_id: current_user.id) } }

    it "記事のレコードが作成される" do
      expect { subject }.to change { Article.count }.by(1)
      expect(response).to have_http_status(204)
    end
  end

  describe "PATCH /articles/:id" do
    subject { patch(article_path(article.id), params: params) }
    let!(:article) { create(:article, user_id: current_user.id) }
    let(:current_user) { create(:user) }
    let(:params) { { article: { title: Faker::Lorem.sentence, created_at: Time.current } } }

    it "指定した記事のレコードが更新される" do
      expect { subject }.to change { Article.find(article.id).title }.from(article.title).to(params[:article][:title])
      expect { subject }.not_to change { Article.find(article.id).body }
      expect { subject }.not_to change { Article.find(article.id).created_at }
      expect(response).to have_http_status(204)
    end
  end
end
