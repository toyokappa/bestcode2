require "rails_helper"

RSpec.describe Course, type: :model do
  describe "validation" do
    describe "#name" do
      let(:course) { build :course, name: nil }
      before { course.valid? }

      it "必須である" do
        expect(course.errors[:name]).to include("を入力してください")
      end
    end
  end

  describe ".with_alive_contracts" do
    let(:user) { create :user }
    let(:plan) { create :plan }
    let(:courses) { create_list :course, 6, plan: plan }

    before do
      create(:contract, user: user, course: courses[0], state: :applying)
      create(:contract, user: user, course: courses[1], state: :waiting_for_payment)
      create(:contract, user: user, course: courses[2], state: :under_contract)
      create(:contract, user: user, course: courses[3], state: :finished)
      create(:contract, user: user, course: courses[4], state: :canceled)
    end

    it { expect(Course.with_alive_contracts.count).to eq 3 }
  end
end
