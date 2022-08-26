# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { create(:user) }

  describe 'show' do
    it 'ユーザーページが存在すること' do
      sign_in_as(user)
      click_on 'nav_user_icon'
      expect(page).to have_content 'Alice'
    end
  end

  describe 'create' do
    context 'Twitter認証を使う場合' do
      it 'ユーザーを作成できること' do
        mock_auth(:twitter)
        visit root_path
        expect do
          click_on 'ユーザー登録'
          click_on 'Twitterで新規登録'
          click_on 'アカウント登録'
          expect(page).to have_content 'アカウントを登録しました'
          expect(page).to have_content 'Alice'
        end.to change { User.count }.by(1)
      end

      it 'デフォルト画像を使用してユーザー登録すること' do
        mock_auth(:twitter)
        visit root_path
        expect do
          click_on 'ユーザー登録'
          click_on 'Twitterで新規登録'
          choose 'user_icon_url_icon_user_m_png'
          click_on 'アカウント登録'
          expect(page).to have_content 'アカウントを登録しました'
          expect(page).to have_selector "img[src*='icon_user_m']"
        end.to change { User.count }.by(1)
      end
    end

    context 'Google認証を使う場合' do
      it 'ユーザーを作成できること' do
        mock_auth(:google)
        visit root_path
        expect do
          click_on 'ユーザー登録'
          click_on 'Googleで新規登録'
          click_on 'アカウント登録'
          expect(page).to have_content 'アカウントを登録しました'
          expect(page).to have_content 'Bob'
        end.to change { User.count }.by(1)
      end
    end
  end

  describe 'update' do
    it 'ユーザーの情報を編集できること' do
      sign_in_as(user)
      visit user_path(user)
      click_on 'アカウント編集'
      fill_in 'アカウント名', with: 'Carol'
      click_on 'アカウント更新'
      expect(page).to have_content 'ユーザー情報を編集しました'
      expect(page).to have_content 'Carol'
      expect(page).to_not have_content 'Alice'
    end
  end

  describe 'destroy' do
    it 'ユーザーを削除できること' do
      sign_in_as(user)
      visit user_path(user)
      expect do
        click_on 'アカウント編集'
        click_on 'アカウント削除'
        page.accept_confirm 'アカウントを削除してもよろしいですか？'
        expect(page).to have_content 'アカウントを削除しました'
      end.to change { User.count }.by(-1)
    end
  end
end
