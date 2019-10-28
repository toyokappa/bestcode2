require "rails_helper"

RSpec.describe "PlanSearch", type: :system do
  let!(:plan1) { create :plan, name: "リモートワークでの働き方を伝授" }
  let!(:plan2) { create :plan, name: "Railsエンジニアに転職する方法教えます", description: "私はリモートで働いています。" }
  let!(:plan3) { create :plan, name: "エンジニアとして即戦力で働く方法をレクチャーします" }
  let!(:plan4) { create :plan, name: "副業で月5万円稼ぐための学習サポート" }

  before do
    create_list :plan, 6
    create :course, plan: plan2
    create :course, plan: plan3, name: "リモートコース"
    create :course, plan: plan4, description: "リモートによるビデオチャットでの受講となります"
    visit root_path
    fill_in "keyword", with: "#{keyword}\n"
  end

  context "キーワードを入力して検索を行った場合" do
    let(:keyword) { "リモート" }

    it "該当の検索件数が表示される" do
      expect(page).to have_content "4人のメンターが見つかりました"
    end

    it "該当のプランが表示される" do
      expect(page).to have_content "リモートワークでの働き方を伝授"
      expect(page).to have_content "Railsエンジニアに転職する方法教えます"
      expect(page).to have_content "エンジニアとして即戦力で働く方法をレクチャーします"
      expect(page).to have_content "副業で月5万円稼ぐための学習サポート"
    end
  end

  context "キーワードを入力せずに検索を行った場合" do
    let(:keyword) { nil }

    it "プランの全件数が表示される" do
      expect(page).to have_content "10人のメンターが見つかりました"
    end
  end

  context "1件も検索に引っかからなかった場合" do
    let(:keyword) { "hogehoge" }

    it "メンターが見つからない旨のメッセージが表示される" do
      expect(page).not_to have_content "人のメンターが見つかりました"
      expect(page).to have_content "メンターが見つかりませんでした"
    end
  end
end
