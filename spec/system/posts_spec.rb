# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  let(:user) { create(:user) }
  let!(:post) { create(:post, user_id: user.id) }

  describe 'index' do
    let(:user2) { create(:g_user) }
    let!(:post2) { create(:post2, user_id: user.id) }
    let!(:post3) { create(:post3, user_id: user.id) }
    let!(:post4) { create(:post4, user_id: user.id) }
    let!(:like) { create(:like, user_id: user.id, post_id: post2.id) }
    let!(:like2) { create(:like2, user_id: user.id, post_id: post3.id) }
    let!(:like3) { create(:like, user_id: user2.id, post_id: post3.id) }

    it '標準では人気順で記事が並んでいること' do
      visit root_path
      within '.posts' do
        post_title = all('.title').map(&:text)
        expect(post_title).to eq %w[1日前の記事 10分前の記事 2日前の記事 看護記事]
      end
    end

    it 'タブから記事を新着順に並び替えること' do
      visit root_path
      find('a', text: '新着順').click
      within '.posts' do
        post_title = all('.title').map(&:text)
        expect(post_title).to eq %w[看護記事 10分前の記事 1日前の記事 2日前の記事]
      end
    end
  end

  describe 'show' do
    it '作成した記事の詳細ページが存在すること' do
      sign_in_as(user)
      find('.card-link').click
      expect(page).to have_content '看護記事'
    end
  end

  describe 'create' do
    it 'サインインしたユーザーが記事投稿すること' do
      sign_in_as(user)
      expect do
        click_on '記事を投稿する'
        fill_in 'URL',	with: 'https://example.net'
        click_on '記事の投稿'
        expect(page).to have_content '「Example Domain」を登録しました'
      end.to change { Post.count }.by(1)
    end

    it '重複したURL記事では投稿できないこと' do
      sign_in_as(user)
      expect do
        click_on '記事を投稿する'
        fill_in 'URL',	with: 'https://example.com'
        click_on '記事の投稿'
        expect(page).to have_content '記事投稿に失敗しました'
      end.to change { Post.count }.by(0)
    end

    it 'サインインしていないユーザーは記事投稿ができないこと' do
      visit root_path
      click_on '記事を投稿する'
      fill_in 'URL',	with: 'https://example.com'
      click_on '記事の投稿'
      expect(page).to have_content '記事投稿をするにはログインが必要です'
    end
  end

  describe 'destroy' do
    let!(:post2) { create(:post2, user_id: user.id) }

    before do
      sign_in_as(user)
    end

    it '記事詳細画面から記事を1件削除できること' do
      visit post_path(post)
      expect do
        click_on '記事の削除'
        page.accept_confirm '「看護記事」を削除してもよろしいですか？'
        expect(page).to have_content '「看護記事」を削除しました'
      end.to change { Post.count }.by(-1)
    end

    it '投稿したユーザーがユーザーページから記事を1件削除できること' do
      visit user_path(user)
      expect do
        first('.delete-button').click
        page.accept_confirm '記事を削除してもよろしいですか？'
        expect(page).to have_content '記事を削除しました'
      end.to change { Post.count }.by(-1)
    end
  end
end
