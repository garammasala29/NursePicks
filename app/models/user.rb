# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  with_options presence: true do
    validates :uid
    validates :provider
    validates :name, length: { maximum: 28 }
  end
  validates :uid, uniqueness: { scope: :provider }

  def self.find_from_omniauth(auth_hash)
    provider = auth_hash[:provider]
    uid = auth_hash[:uid]
    User.where(provider: provider, uid: uid).first
  end

  def self.new_from_omniauth(auth_hash)
    User.new(
      name: auth_hash[:info][:name],
      icon_url: auth_hash[:info][:image],
      provider: auth_hash[:provider],
      uid: auth_hash[:uid]
    )
  end

  def liked?(post)
    likes.exists?(post_id: post.id)
  end
end
