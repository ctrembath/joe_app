get '/gigs' do
	@gigs = Gig.all
	@gigs.each do |gig|
		gig.destroy if Date.parse(gig.date) < Date.today
	end
	# dates_in_order = sort_by_date(@gigs)
	# @gigs.each do |gig|
	# 	if gig.date == dates_in_order[0]
	# 		puts gig
	# 		@gigs.unshift(@gigs.delete_at(@gigs.index(gig)))
	# 	end
	# end
	erb :gigs
end

post '/gigs' do
	date = params["date"]
	date_object = Date.parse(date)
	newdate = date_object.strftime('%d-%m-%Y')
	venue = params["venue"]
	url = params["url"]
	@gig = Gig.new(	:date => newdate, 
									:venue => venue, 
									:url => url
								)
	if @gig.save
		redirect to '/gigs', flash[:notice] = "Gig added"
	else
		flash[:notice] = "Please make sure all fields are filled out when adding a new gig night."
		redirect '/artist'
	end
end