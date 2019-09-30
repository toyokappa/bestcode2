require "rails_helper"

RSpec.describe User, type: :model do
  describe "validation" do
    before { create :user, name: "same_name" }

    it "user.nameはユニークである" do
      actual_user = build(:user, name: "same_name")
      actual_user.valid?
      expect(actual_user.errors[:name]).to include("はすでに存在します")
    end

    it "user.nameはユニークであるが、大文字小文字は区別されない" do
      actual_user = build(:user, name: "Same_Name")
      actual_user.valid?
      expect(actual_user.errors[:name]).to include("はすでに存在します")
    end
  end

  describe ".with_alive_contracts" do
    let(:user) { create :user }
    let(:courses) { create_list :course, 6 }

    before do
      create(:contract, user: user, course: courses[0], state: :applying)
      create(:contract, user: user, course: courses[1], state: :waiting_for_payment)
      create(:contract, user: user, course: courses[2], state: :under_contract)
      create(:contract, user: user, course: courses[3], state: :finished)
      create(:contract, user: user, course: courses[4], state: :canceled)
    end

    it { expect(User.with_alive_contracts(user_type: :mentee).count).to eq 1 }
    it { expect(User.with_alive_contracts(user_type: :mentor).count).to eq 3 }
  end

  describe ".find_or_create_by_omniauth" do
    let!(:user) { create :user }
    let(:auth) {
      OmniAuth::AuthHash.new({
        provider: "github",
        uid: uid,
        info: {
          nickname: "sample_user",
          name: "Sample User",
          email: "user@sample.com",
          image: Faker::LoremFlickr.image,
        },
        credentials: {
          token: "abcdefg",
        },
      })
    }

    context "ユーザーが存在する場合" do
      let(:uid) { user.uid }

      it "既存のユーザーが返却される" do
        auth_user = User.find_or_create_by_omniauth(auth)
        expect(auth_user).to eq user
      end

      it "アクセストークンが更新される" do
        User.find_or_create_by_omniauth(auth)
        user.reload
        expect(user.access_token).to eq "abcdefg"
      end
    end

    context "ユーザーが存在しない場合" do
      let(:uid) { "sample01234" }

      it "新たにユーザーが作成される" do
        auth_user = User.find_or_create_by_omniauth(auth)
        expect(auth_user.name).to eq "sample_user"
      end
    end
  end

  describe "#contracting?" do
    let!(:user) { create :user }
    let!(:course) { create :course }

    context "契約が存在しない場合" do
      it { expect(user.contracting?(course.id)).to be false }
    end

    context "申請中ステータスの契約が存在する場合" do
      before { create :contract, user: user, course: course, state: :applying }

      it { expect(user.contracting?(course.id)).to be true }
    end

    context "申請中ステータスの契約が存在する場合" do
      before { create :contract, user: user, course: course, state: :waiting_for_payment }

      it { expect(user.contracting?(course.id)).to be true }
    end

    context "申請中ステータスの契約が存在する場合" do
      before { create :contract, user: user, course: course, state: :under_contract }

      it { expect(user.contracting?(course.id)).to be true }
    end

    context "申請中ステータスの契約が存在する場合" do
      before { create :contract, user: user, course: course, state: :finished }

      it { expect(user.contracting?(course.id)).to be false }
    end

    context "申請中ステータスの契約が存在する場合" do
      before { create :contract, user: user, course: course, state: :canceled }

      it { expect(user.contracting?(course.id)).to be false }
    end
  end
end
