require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    before { create :user }

    it 'user.nameはユニークである' do
      actual_user = build(:user, uid: 'actual01234')
      actual_user.valid?
      expect(actual_user.errors[:name]).to include("has already been taken")
    end

    it 'user.nameはユニークであるが、大文字小文字は区別される' do
      actual_user = build(:user, uid: 'actual01234', name: 'Test_User')
      actual_user.valid?
      expect(actual_user.errors[:name]).to include("has already been taken")
    end
  end

  describe '.find_or_create_by_omniauth' do
    let!(:user) { create :user }
    let(:auth) {
      OmniAuth::AuthHash.new({
        provider: 'twitter',
        uid: uid,
        info: {
          nickname: 'sample_user',
          name: 'Sample User',
          email: 'user@sample.com',
        },
        credentials: {
          token: 'abcdefg',
        },
      })
    }

    context 'ユーザーが存在する場合' do
      let!(:uid) { user.uid }

      it '既存のユーザーが返却される' do
        auth_user = User.find_or_create_by_omniauth(auth)
        expect(auth_user).to eq user
      end
      
      it 'アクセストークンが更新される' do
        User.find_or_create_by_omniauth(auth)
        user.reload
        expect(user.access_token).to eq 'abcdefg'
      end
    end
    context 'ユーザーが存在しない場合' do
      let!(:uid) { 'sample01234' }

      it '新たにユーザーが作成される' do
        auth_user = User.find_or_create_by_omniauth(auth)
        expect(auth_user.name).to eq 'sample_user'
      end
    end
  end
end
