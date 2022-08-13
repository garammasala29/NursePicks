# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context '#find_from_omniauth' do
    it '有効なproviderとuidに対応するuserが存在すること' do
      user = FactoryBot.create(:user)
      auth_hash = { provider: user.provider, uid: user.uid }
      expect(User.find_from_omniauth(auth_hash)).to eq user
    end

    it '無効なproviderとuidが渡されるとnilが返ること' do
      user = FactoryBot.build(:user)
      auth_hash = { provider: 'google_oauth2', uid: nil }
      expect(User.find_from_omniauth(auth_hash)).to be nil
    end
  end
end
