# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Likes', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user_id: user.id) }

  describe 'create' do
    it '記事一覧画面からいいねができること' do
      post
      sign_in_as(user)
      expect do
        find('.fa-regular.fa-heart').click
        expect(page).to have_content 'いいねしました'
      end.to change { Like.count }.by(1)
    end

    it '記事詳細画面からいいねができること' do
      sign_in_as(user)
      visit post_path(post)
      expect do
        find('.fa-regular.fa-heart').click
        expect(page).to have_content 'いいねしました'
      end.to change { Like.count }.by(1)
    end
  end

  describe 'destroy' do
    before do
      FactoryBot.create(:like, user_id: user.id, post_id: post.id)
      sign_in_as(user)
    end

    it '記事一覧画面からいいねを取り消せること' do
      expect do
        find('.fa-solid.fa-heart').click
        expect(page).to have_content 'いいねを取り消しました'
      end.to change { Like.count }.by(-1)
    end

    it '記事詳細画面からいいねを取り消せること' do
      visit post_path(post)
      expect do
        find('.fa-solid.fa-heart').click
        expect(page).to have_content 'いいねを取り消しました'
      end.to change { Like.count }.by(-1)
    end

    it '投稿したユーザーがユーザーページからいいねを取り消せること' do
      visit user_path(user)
      expect do
        find('a', text: 'いいねした記事').click
        find('.delete-button').click
        page.accept_confirm 'いいねを削除してもよろしいですか？'
        expect(page).to have_content 'いいねを削除しました'
      end.to change { Like.count }.by(-1)
    end
  end
end
