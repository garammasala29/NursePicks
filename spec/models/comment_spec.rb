# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  it '有効なファクトリを持つこと' do
    comment = FactoryBot.build(:comment)
    expect(comment).to be_valid
  end

  it 'ユーザーがいなければコメントが無効であること' do
    comment = FactoryBot.build(:comment, user_id: nil)
    comment.valid?
    expect(comment.errors[:user]).to include('を入力してください')
  end

  it '記事がなければコメントが無効であること' do
    comment = FactoryBot.build(:comment, post_id: nil)
    comment.valid?
    expect(comment.errors[:post]).to include('を入力してください')
  end

  it 'コメントがなければ投稿が無効であること' do
    comment = FactoryBot.build(:comment, content: nil)
    comment.valid?
    expect(comment.errors[:content]).to include('を入力してください')
  end
end
