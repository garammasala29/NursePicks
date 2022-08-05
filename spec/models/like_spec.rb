# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  it '有効なファクトリを持つこと' do
    like = FactoryBot.build(:like)
    expect(like).to be_valid
  end

  it 'ユーザーがいなければいいねが無効であること' do
    like = FactoryBot.build(:like, user_id: nil)
    like.valid?
    expect(like.errors[:user]).to include('を入力してください')
  end

  it '記事がなければいいねが無効であること' do
    like = FactoryBot.build(:like, post_id: nil)
    like.valid?
    expect(like.errors[:post]).to include('を入力してください')
  end
end
