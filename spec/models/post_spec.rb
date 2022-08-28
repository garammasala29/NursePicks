# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }

  it '有効なファクトリを持つこと' do
    expect(build(:post)).to be_valid
  end

  it 'ユーザーがいなければ記事投稿が無効であること' do
    post = build(:post, user_id: nil)
    post.valid?
    expect(post.errors[:user]).to include('を入力してください')
  end

  it 'URLがなければ記事投稿が無効であること' do
    post = build(:post2, user_id: user.id, url: nil)
    post.valid?
    expect(post.errors[:url]).to include('を入力してください')
  end

  it 'タイトルがなければ記事投稿が無効であること' do
    post = build(:post, user_id: user.id, title: nil)
    post.valid?
    expect(post.errors[:title]).to include('を入力してください')
  end

  it '重複したURLが存在するなら記事投稿が無効であること' do
    create(:post)
    post = build(:post)
    post.valid?
    expect(post.errors[:url]).to include('はすでに存在します')
  end
end
