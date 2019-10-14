class SessionController< ApplicationController
	def authenticate
		user=User.find_by(email:params[:email].downcase)
		if user && user.authenticate(params[:password])
			session[:user_id]=user.id
			session[:token]="abcde"
			render json: {token:"abcde"}, status: 200
		else
			response = { message: 'invalid credentials' }
        	render json: response, status: 401
		end

	end

end