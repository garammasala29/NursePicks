# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it '有効なファクトリを持つこと' do
    expect(build(:user)).to be_valid
  end

  it '名前がなければユーザーが無効であること' do
    user = build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include('を入力してください')
  end

  it 'uidがなければユーザーが無効であること' do
    user = build(:user, uid: nil)
    user.valid?
    expect(user.errors[:uid]).to include('を入力してください')
  end

  it 'providerがなければユーザーが無効であること' do
    user = build(:user, provider: nil)
    user.valid?
    expect(user.errors[:provider]).to include('を入力してください')
  end

  it 'uidとproviderが重複したユーザーは作成できないこと' do
    create(:user)
    user = build(:user)
    user.valid?
    expect(user.errors[:uid]).to include('はすでに存在します')
  end

  describe '#find_from_omniauth' do
    let!(:user) { create(:user) }

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
        uid: '12345',
        info: {
          name: 'Alice',
          image: 'https://example.com/image'
        }
      }
      user = User.new_from_omniauth(auth_hash)
      expect(user.provider).to eq 'twitter'
      expect(user.uid).to eq '12345'
      expect(user.name).to eq 'Alice'
      expect(user.icon_url).to eq 'https://example.com/image'
      expect(user).to be_truthy
    end
  end

  describe '#liked?' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user_id: user.id) }

    it 'ユーザーが特定の記事をいいね済みであること' do
      create(:like, user_id: user.id, post_id: post.id)
      expect(user.liked?(post)).to be_truthy
    end

    it 'ユーザーが特定の記事をいいね済みではないこと' do
      expect(user.liked?(post)).to be_falsy
    end
  end
end
