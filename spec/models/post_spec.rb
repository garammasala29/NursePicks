# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  it '有効なファクトリを持つこと' do
    post = FactoryBot.build(:post)
    expect(post).to be_valid
  end

  it 'ユーザーがいなければコメントが無効であること' do
    post = FactoryBot.build(:post, user_id: nil)
    post.valid?
    expect(post.errors[:user]).to include('を入力してください')
  end

  it 'URLがなければ記事投稿が無効であること' do
    post = FactoryBot.build(:post, url: nil)
    post.valid?
    expect(post.errors[:url]).to include('を入力してください')
  end

  it '重複したURLが存在するなら記事投稿が無効であること' do
    FactoryBot.create(:post)
    post = FactoryBot.build(:post)
    post.valid?
    expect(post.errors[:url]).to include('はすでに存在します')
  end
end
