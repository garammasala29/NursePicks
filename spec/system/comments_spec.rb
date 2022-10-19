# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comments', type: :system do
  let(:user) { create(:user) }
  let(:post) { create(:post, user_id: user.id) }

  describe 'create' do
    it 'コメントができること' do
      sign_in_as(user)
      visit post_path(post)
      expect do
        fill_in 'コメント', with: 'コメントのテスト'
        click_on 'コメントの投稿'
      end.to change { Comment.count }.by(1)
    end

    it '空欄ではコメントができないこと' do
      sign_in_as(user)
      visit post_path(post)
      expect do
        fill_in 'コメント', with: ' '
        click_on 'コメントの投稿'
        expect(page).to have_content 'コメント投稿に失敗しました'
        expect(page).to have_content 'コメントを入力してください'
      end.to change { Comment.count }.by(0)
    end

    it 'サインインしていないユーザーはコメント投稿できないこと' do
      visit post_path(post)
      expect(page).to have_content 'ログインするとコメントできます'
    end
  end

  describe 'destroy' do
    let!(:comment) { create(:comment, user_id: user.id, post_id: post.id) }
    let!(:comment2) { create(:comment2, user_id: user.id, post_id: post.id) }

    it '投稿したユーザーが記事詳細ページから1件目のコメントを削除できること' do
      sign_in_as(user)
      visit post_path(post)
      expect do
        all('a', text: '削除')[1].click
        page.accept_confirm '「コメントテスト」を削除してもよろしいですか？'
        expect(page).to have_content 'コメントを削除しました'
      end.to change { Comment.count }.by(-1)
    end

    it '投稿したユーザーがユーザーページから1件目のコメントを削除できること' do
      sign_in_as(user)
      visit user_path(user)
      expect do
        find('a', text: 'コメント').click
        first('.delete-button').click
        page.accept_confirm 'コメントを削除してもよろしいですか？'
        expect(page).to have_content 'コメントを削除しました'
      end.to change { Comment.count }.by(-1)
    end
  end
end
