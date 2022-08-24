# frozen_string_literal: true

require_relative '../sign_in_helper'

RSpec.configure do |config|
  config.before type: :system do
    driven_by :selenium, using: :headless_chrome
  end
end
