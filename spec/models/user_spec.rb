# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#find_from_omniauth' do
    let(:user) { FactoryBot.create(:user) }

    it '有効なproviderとuidに対応するuserが存在すること' do
      auth_hash = { provider: user.provider, uid: user.uid }
      expect(User.find_from_omniauth(auth_hash)).to eq user
    end

    it '無効なproviderが渡されるとnilが返ること' do
      auth_hash = { provider: 'google_oauth2', uid: user.uid }
      expect(User.find_from_omniauth(auth_hash)).to be nil
    end

    it '無効なuidが渡されるとnilが返ること' do
      auth_hash = { provider: user.provider, uid: '67890' }
      expect(User.find_from_omniauth(auth_hash)).to be nil
    end
  end

  describe '#new_from_omniauth' do
    it '引数omniauthからuserオブジェクトが返ること' do
      auth_hash = {
        provider: 'twitter',
        uid: 'a7ed37f9-56bb-4ed1-b858-2129492b9f68',
        info: {
          name: 'Alice',
          image: 'https://example.com/image'
        }
      }
      user = User.new_from_omniauth(auth_hash)
      expect(user.provider).to eq 'twitter'
      expect(user.uid).to eq 'a7ed37f9-56bb-4ed1-b858-2129492b9f68'
      expect(user.name).to eq 'Alice'
      expect(user.icon_url).to eq 'https://example.com/image'
      expect(user).to be_truthy
    end
  end

  describe '#liked?' do
    let(:user) { FactoryBot.build(:user) }
    let(:post) { FactoryBot.build(:post) }

    it 'ユーザーが特定の記事をいいね済みであること' do
      FactoryBot.create(:like)
      expect(user.liked?(post)).to be_truthy
    end

    it 'ユーザーが特定の記事をいいね済みではないこと' do
      expect(user.liked?(post)).to be_falsy
    end
  end
end
