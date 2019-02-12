# frozen_string_literal: true

require 'application_system_test_case'

class GamesTest < ApplicationSystemTestCase
  test 'Going to /new gives us a new random grid to play with' do
    visit new_url

    assert test: 'New game'
    assert_selector '.card', count: 10
  end

  test 'fill the form word and get a message that the is not in the grid' do
    visit new_url
    fill_in 'word', with: 'Hellooo'
    click_on 'Play'

    assert_text "can't be built out of"
  end

  test 'fill the form word and get a message that the is not in the grid' do
    visit new_url
    fill_in 'word', with: 'Hellooo'
    click_on 'Play'

    assert_text "can't be built out of"
  end
end
