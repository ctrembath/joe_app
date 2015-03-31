require 'spec_helper'

feature 'Signing up' do 

	scenario 'when trying to make a login' do
		visit '/new_artist'
		expect{ sign_up }.to change(User, :count).by(1)
		expect(page).to have_content('Hey Joe Man')
		expect(User.first.email).to eq('joe@example.com')
	end

	scenario 'with a password that doesn\'t match' do
		visit '/new_artist'
		expect{ sign_up('name','a@a.com','pass','wrong') }.to change(User, :count).by(0)
		expect(current_path).to eq('/new_artist')
		expect(page).to have_content('Your passwords didn\'t match')
	end
end

feature 'Signing in and out: ' do

	before(:each) do
		User.create(:name => 'Joe',
								:email => 'j@t.com',
								:password => 'test',
								:password_confirmation => 'test')
	end

	scenario 'signs in with correct login details' do
		visit '/artist'
		expect(page).not_to have_content('Hey Joe Man')
		visit '/artist_session'
		sign_in('j@t.com', 'test')
		expect(page).to have_content('Hey Joe Man')
	end

	scenario 'signs in with incorrect credentials' do
		visit '/artist'
		expect(page).not_to have_content('Hey Joe Man')
		visit '/artist_session'
		sign_in('j@t.com', 'wrong')
		expect(page).not_to have_content('Hey Joe Man')
	end

	scenario 'while being signed in' do
		visit '/artist_session'
		sign_in('j@t.com', 'test')
		click_button 'Log out'
		expect(page).not_to have_content('Hey Joe Man')
	end

end
