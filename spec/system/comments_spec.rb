# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comments', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user_id: user.id) }

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
      fill_in 'コメント', with: ' '
      click_on 'コメントの投稿'
      expect(page).to have_content 'コメント投稿に失敗しました'
      expect(page).to have_content 'コメントを入力してください'
    end

    it 'サインインしていないユーザーはコメント投稿できないこと' do
      visit post_path(post)
      expect(page).to have_content 'ログインするとコメントすることができます'
    end
  end

  describe 'destroy' do
    before do
      FactoryBot.create(:comment, user_id: user.id, post_id: post.id)
      sign_in_as(user)
    end

    it '投稿したユーザーが記事詳細ページからコメントを削除できること' do
      visit post_path(post)
      expect do
        click_on '削除'
        page.accept_confirm '「コメントテスト」を削除してもよろしいですか？'
        expect(page).to have_content 'コメントを削除しました'
      end.to change { Comment.count }.by(-1)
    end

    it '投稿したユーザーがユーザーページからコメントを削除できること' do
      visit user_path(user)
      expect do
        find('a', text: 'コメント').click
        find('.delete-button').click
        page.accept_confirm 'コメントを削除してもよろしいですか？'
        expect(page).to have_content 'コメントを削除しました'
      end.to change { Comment.count }.by(-1)
    end
  end
end
