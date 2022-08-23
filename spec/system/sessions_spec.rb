# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:g_user) { FactoryBot.create(:g_user) }

  describe 'create' do
    it 'Twitter認証でログインできる' do
      sign_in_as(user)
      expect(page).to have_content 'ログインしました'
    end

    it 'Google認証でログインできる' do
      set_omniauth(:google_oauth2)
      g_user
      visit root_path
      click_on 'ログイン'
      click_on 'Googleでログイン'
      expect(page).to have_content 'ログインしました'
    end
  end

  describe 'destroy' do
    it 'ユーザーがログアウトできる' do
      sign_in_as(user)
      click_button 'ログアウト'
      expect(page).to have_content 'ログアウトしました'
    end
  end
end
