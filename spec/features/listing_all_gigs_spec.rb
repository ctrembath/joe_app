require 'spec_helper'

feature 'User opens the app to see gig dates' do 

	before(:each) {
		Gig.create(:venue => "XOYO", :date => "15.04.15", :url => "www.xoyo.co.uk")
	}

	scenario 'on the landing page there is a button that says gigs' do
		visit '/'
		expect(page).to have_link('Upcoming Events')
	end

	scenario 'they can see a list of upcoming gigs' do
		visit '/'
		click_link 'Upcoming Events'
		expect(page).to have_content('XOYO')
		expect(page).to have_content('15.04.15')
	end
end
