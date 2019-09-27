require "rails_helper"

RSpec.describe "MentorList", type: :system do
  let(:mentee) { create :user }
  let(:mentor) { create :user, display_name: "Test Mentor" }
  let(:plan)   { create :plan, user: mentor }
  let(:course) { create :course, plan: plan }

  context "コースに契約をしていない場合" do
    before do
      sign_in mentee
      visit users_mentors_path
    end

    it "mentorは表示されない" do
      expect(page).to have_content "現在契約中のメンターはいません"
    end
  end

  context "1件のコースに契約をしている場合" do
    before do
      create :contract, course: course, user: mentee
      sign_in mentee
      visit users_mentors_path
    end

    it "1人のmentor表示される" do
      expect(page).to have_content "Test Mentor", count: 1
    end

    it "1種類のコースが表示される" do
      expect(page).to have_content "Test Course", count: 1
    end
  end

  context "複数のメンターのコースに契約をしている場合" do
    let(:other_mentor) { create :user, display_name: "Other Mentor" }
    let(:other_plan)   { create :plan, user: other_mentor }
    let(:other_course) { create :course, name: "Other Course", plan: other_plan }

    before do
      create :contract, course: course, user: mentee
      create :contract, course: other_course, user: mentee
      sign_in mentee
      visit users_mentors_path
    end

    it "複数人のmentor表示される" do
      expect(page).to have_content "Test Mentor", count: 1
      expect(page).to have_content "Other Mentor", count: 1
    end

    it "1種類のコースが表示される" do
      expect(page).to have_content "Test Course", count: 1
      expect(page).to have_content "Other Course", count: 1
    end
  end

  context "1人のメンターの複数件のコースに契約をしている場合" do
    let(:other_course) { create :course, name: "Other Course", plan: plan }

    before do
      create :contract, course: course, user: mentee
      create :contract, course: other_course, user: mentee
      sign_in mentee
      visit users_mentors_path
    end

    it "1人のmentor表示される" do
      expect(page).to have_content "Test Mentor", count: 1
    end

    it "複数種類のコースが表示される" do
      expect(page).to have_content "Test Course", count: 1
      expect(page).to have_content "Other Course", count: 1
    end
  end

  context "すべてコースの契約が終了している場合" do
    before do
      create :contract, course: course, state: :finished, user: mentee
      sign_in mentee
      visit users_mentors_path
    end

    it "一覧には表示されない" do
      expect(page).to have_content "現在契約中のメンターはいません"
    end
  end

  context "一部のコースの契約が残っている場合" do
    let(:alive_course) { create :course, name: "Alive Course", plan: plan }

    before do
      create :contract, course: course, state: :finished, user: mentee
      create :contract, course: alive_course, user: mentee
      sign_in mentee
      visit users_mentors_path
    end

    it "契約中のコースのみ表示される" do
      expect(page).to have_content "Alive Course", count: 1
      expect(page).not_to have_content "Test Course"
    end
  end
end
