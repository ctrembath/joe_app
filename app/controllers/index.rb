get '/' do 
	s3_connect
	@tracks = Track.all	
	@my_bucket = AWS::S3::Bucket.find('yo-man')
	all_track_names
	erb :index
end

post '/' do
	bucket = 'yo-man'
	title = params["title"]
	tune = params["tune"][:tempfile]
	@track = Track.create(:title => title, :tune => tune)
	if @track.save
		save_file_to_aws(title, tune)
		redirect '/', flash[:notice] = "Track added"
	else
		flash[:notice] = "Something's up with the file upload. Please make sure all fields are filled out."
		redirect '/artist'
	end
end