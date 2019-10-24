require 'rails_helper'

RSpec.describe Resume, type: :model do
  describe "validation" do
    describe "#description" do
      it "必須である" do
        resume = build(:resume, description: nil)
        resume.valid?
        expect(resume.errors[:description]).to include("を入力してください")
      end
    end
  end
end
