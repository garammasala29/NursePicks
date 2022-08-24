# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user_id: user.id) }

  describe 'index' do
    it '作成した記事が表示されていること' do
      post
      visit posts_path
      expect(page).to have_content '看護記事'
    end
  end

  describe 'show' do
    it '作成した記事の詳細ページが存在すること' do
      post
      sign_in_as(user)
      visit post_path(post)
    end
  end

  describe 'create' do
    it 'サインインしたユーザーが記事投稿すること' do
      sign_in_as(user)
      visit posts_path
      expect do
        click_on '記事を投稿する'
        fill_in 'URL',	with: 'https://example.com'
        click_on '記事の投稿'
        expect(page).to have_content '「Example Domain」を登録しました'
      end.to change { Post.count }.by(1)
    end

    it 'サインインしていないユーザーは記事投稿ができないこと' do
      visit posts_path
      click_on '記事を投稿する'
      fill_in 'URL',	with: 'https://example.com'
      click_on '記事の投稿'
      expect(page).to have_content '記事投稿をするにはログインが必要です'
    end
  end

  describe 'destroy' do
    before do
      sign_in_as(user)
    end

    it '記事詳細画面から記事を削除できること' do
      visit post_path(post)
      expect do
        click_on '記事の削除'
        page.accept_confirm '「看護記事」を削除してもよろしいですか？'
        expect(page).to have_content '「看護記事」を削除しました'
      end.to change { Post.count }.by(-1)
    end

    it '投稿したユーザーがユーザーページから記事を削除できること' do
      post
      visit user_path(user)
      expect do
        find('.delete-button').click
        page.accept_confirm '記事を削除してもよろしいですか？'
        expect(page).to have_content '記事を削除しました'
      end.to change { Post.count }.by(-1)
    end
  end
end
