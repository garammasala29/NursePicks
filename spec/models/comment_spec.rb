# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, user_id: user.id) }

  it '有効なファクトリを持つこと' do
    expect(build(:comment)).to be_valid
  end

  it 'ユーザーがいなければコメントが無効であること' do
    comment = build(:comment, user_id: nil, post_id: post.id)
    comment.valid?
    expect(comment.errors[:user]).to include('を入力してください')
  end

  it '記事がなければコメントが無効であること' do
    comment = build(:comment, user_id: user.id, post_id: nil)
    comment.valid?
    expect(comment.errors[:post]).to include('を入力してください')
  end

  it 'コメントがなければ投稿が無効であること' do
    comment = build(:comment, content: nil, user_id: user.id, post_id: post.id)
    comment.valid?
    expect(comment.errors[:content]).to include('を入力してください')
  end
end
