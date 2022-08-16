# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Welcome', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:g_user) { FactoryBot.create(:g_user) }

  it 'ユーザーがTwitter認証でログインできる' do
    sign_in_as(user)
    expect(page).to have_content 'ログインしました'
  end
end
