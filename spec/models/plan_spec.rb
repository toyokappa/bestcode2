require "rails_helper"

RSpec.describe Plan, type: :model do
  describe "validation" do
    describe "#name" do
      let(:plan) { build :plan, name: nil }
      before { plan.valid? }

      it "必須である" do
        expect(plan.errors[:name]).to include("を入力してください")
      end
    end
  end

  describe "scope" do
    describe ".search" do
      let!(:plan1) { create :plan, name: "hoge", description: "fuga" }
      let!(:plan2) { create :plan, name: "xxxx", description: "yyyy" }
      let!(:plan3) { create :plan, name: "oraora", description: "mudamuda" }

      before do
        create :course, plan: plan1, name: "aaaa", description: "bbbb"
        create :course, plan: plan2, name: "hogehoge", description: "piyopiyo"
      end

      context "hogeというキーワードを入力した場合" do
        it "2件のプランが返される" do
          plans = Plan.search("hoge")
          expect(plans.count).to eq 2
        end
      end

      context "zzzzというキーワードを入力した場合" do
        it "1件のプランが返される" do
          plans = Plan.search("zzzz")
          expect(plans.count).to eq 0
        end
      end

      context "キーワードを入力しなかった場合" do
        it "すべてのプランが返される" do
          plans = Plan.search
          expect(plans.count).to eq 3
        end
      end
    end
  end
end
