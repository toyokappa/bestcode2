require 'rails_helper'

RSpec.describe Contract, type: :model do
  describe "validation" do
    let!(:contract) { create :contract, state: state }

    context "申請中ステータスの契約が存在する場合" do
      let(:state) { :applying }

      it "同じコースでの追加契約できない" do
        actual_contract = build(:contract, user: contract.user, course: contract.course)
        expect(actual_contract).not_to be_valid
      end
    end

    context "支払い待ちステータスの契約が存在する場合" do
      let(:state) { :waiting_for_payment }

      it "同じコースでの追加契約できない" do
        actual_contract = build(:contract, user: contract.user, course: contract.course)
        expect(actual_contract).not_to be_valid
      end
    end

    context "契約中ステータスの契約が存在する場合" do
      let(:state) { :under_contract }

      it "同じコースでの追加契約できない" do
        actual_contract = build(:contract, user: contract.user, course: contract.course)
        expect(actual_contract).not_to be_valid
      end
    end

    context "契約終了ステータスの契約が存在する場合" do
      let(:state) { :finished }

      it "同じコースでの追加契約できる" do
        actual_contract = build(:contract, user: contract.user, course: contract.course)
        expect(actual_contract).to be_valid
      end

      it "同じコースでの追加契約後に契約を終了できる" do
        actual_contract = create(:contract, user: contract.user, course: contract.course)
        actual_contract.state = :finished
        expect(actual_contract).to be_valid
      end

      it "同じコースでの追加契約後に契約をキャンセルできる" do
        actual_contract = create(:contract, user: contract.user, course: contract.course)
        actual_contract.state = :canceled
        expect(actual_contract).to be_valid
      end
    end

    context "キャンセルステータスの契約が存在する場合" do
      let(:state) { :canceled }

      it "同じコースでの追加契約できる" do
        actual_contract = build(:contract, user: contract.user, course: contract.course)
        expect(actual_contract).to be_valid
      end

      it "同じコースでの追加契約後に契約を終了できる" do
        actual_contract = create(:contract, user: contract.user, course: contract.course)
        actual_contract.state = :finished
        expect(actual_contract).to be_valid
      end

      it "同じコースでの追加契約後に契約をキャンセルできる" do
        actual_contract = create(:contract, user: contract.user, course: contract.course)
        actual_contract.state = :canceled
        expect(actual_contract).to be_valid
      end
    end
  end
end
