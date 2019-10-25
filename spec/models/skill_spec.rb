require "rails_helper"

RSpec.describe Skill, type: :model do
  describe "validation" do
    describe "#name" do
      it "必須である" do
        skill = build(:skill, name: nil)
        skill.valid?
        expect(skill.errors[:name]).to include "を入力してください"
      end
    end

    describe "#level" do
      it "必須である" do
        skill = build(:skill, level: nil)
        skill.valid?
        expect(skill.errors[:level]).to include "を入力してください"
      end
    end

    describe "#experience" do
      it "必須である" do
        skill = build(:skill, experience: nil)
        skill.valid?
        expect(skill.errors[:experience]).to include "を入力してください"
      end
    end
  end
end
