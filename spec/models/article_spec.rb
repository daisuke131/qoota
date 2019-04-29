require "rails_helper"

RSpec.describe Article, type: :model do
  describe "validates presence" do
    let(:user) { create(:user) }

    context "全カラムの値を指定しているとき" do
      let(:article) { create(:article, user_id: user.id) }

      it "articleが作成される" do
        expect(article).to be_valid
      end

      it "投稿したユーザーidが保存される" do
        expect(article.user_id).to eq user.id
      end
    end

    context "titleを指定していないとき" do
      let(:article) { build(:article, title: nil, user_id: user.id) }
      it "エラーになる" do
        article.valid?
        expect(article.errors.messages[:title]).to include "can't be blank"
      end
    end

    context "bodyを指定していないとき" do
      let(:article) { build(:article, body: nil, user_id: user.id) }
      it "エラーになる" do
        article.valid?
        expect(article.errors.messages[:body]).to include "can't be blank"
      end
    end

  end
end
