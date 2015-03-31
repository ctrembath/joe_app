get '/new_artist' do
	@user = User.new
	erb :artist_new
end

post '/artist' do
	@user = User.create(:name => params[:name], 
											:email => params[:email], 
											:password => params[:password],
											:password_confirmation => params[:password_confirmation])
	if @user.save
		session[:user_id] = @user.id
		redirect '/artist'
	else
		flash[:notice] = "Your passwords didn't match"
		redirect '/new_artist'
	end
end

get '/artist_session' do
	erb :artist_session
end

post '/sessions' do
	email, password = params[:email], params[:password]
	user = User.authenticate(email, password)
	if user
		session[:user_id] = user.id
		redirect '/artist'
	else
		flash[:notice] = "Email or password is incorrect"
		erb :artist_session
	end
end

delete '/sessions' do
	flash[:notice] = "Ciao"
	session[:user_id] = nil
	redirect '/'
end