# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Homes', type: :system do
  it '存在しないURLを指定した際に404ページへ遷移すること' do
    visit '/test'
    expect(page).to have_content 'ご指定になったページは存在しません'
  end
end
