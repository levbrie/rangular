require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do												# we're describing the home page
    it "should have the content 'Rangular'" do	# descriptive should
      visit '/static_pages/home'								# actually visit this route (Capybara function visit)
      expect(page).to have_content('Rangular') 	# check for content and expect it using page variable
      																					# provided by Capybara
      																					# if the content's not there, fail
    end
  end
end
