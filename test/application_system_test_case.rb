require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  WINDOW_SIZE = [1400, 1400]
  driven_by :selenium, using: :firefox, screen_size: WINDOW_SIZE
end

class MobileSystemTestCase < ApplicationSystemTestCase
  setup do 
    visit root_path
    current_window.resize_to(375, 812)
  end

  teardown do 
    current_window.resize_to(*ApplicationSystemTestCase::WINDOW_SIZE)
  end
end