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

    describe "#courses" do
      let(:plan) { build :plan, :with_no_courses }
      before { plan.valid? }

      it "最低1件の登録が必須である" do
        expect(plan.errors[:courses]).to include("を最低1件は登録してください")
      end
    end
  end
end
