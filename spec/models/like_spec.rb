# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, user_id: user.id) }

  it '有効なファクトリを持つこと' do
    expect(build(:like)).to be_valid
  end

  it 'ユーザーがいなければいいねが無効であること' do
    like = build(:like, user_id: nil, post_id: post.id)
    like.valid?
    expect(like.errors[:user]).to include('を入力してください')
  end

  it '記事がなければいいねが無効であること' do
    like = build(:like, user_id: user.id, post_id: nil)
    like.valid?
    expect(like.errors[:post]).to include('を入力してください')
  end

  it '同一記事への複数いいねが無効であること' do
    create(:like, user_id: user.id, post_id: post.id)
    like = build(:like, user_id: user.id, post_id: post.id)
    like.valid?
    expect(like.errors[:post_id]).to include('はすでに存在します')
  end
end
