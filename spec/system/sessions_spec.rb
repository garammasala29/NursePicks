# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  let!(:user) { create(:user) }
  let!(:g_user) { create(:g_user) }

  describe 'create' do
    it 'Twitter認証でログインできる' do
      sign_in_as(user, :twitter)
      expect(page).to have_content 'ログインしました'
    end

    it 'Google認証でログインできる' do
      sign_in_as(g_user, :google)
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
