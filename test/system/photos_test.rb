require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  test 'visiting the index' do
    visit photos_url

    assert_selector "h1", text: "photo index view"
  end
end
