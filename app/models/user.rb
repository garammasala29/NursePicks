# frozen_string_literal: true

class User < ApplicationRecord
  def self.from_omniauth(auth_hash)
    provider = auth_hash[:provider]
    uid = auth_hash[:uid]
    User.where(provider: provider, uid: uid).first
  end
end
