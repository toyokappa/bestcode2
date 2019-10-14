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
end
