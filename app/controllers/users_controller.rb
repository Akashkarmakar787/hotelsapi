class UsersController < ApplicationController

def index
	if !params[:email].present?
		render json: {message:"provide username and password for authentication"}, status: 406
    else
		user=User.find_by(email: params[:email])
		if user&& user.authenticate(params[:password])
			@users=User.all
			render json:{users:@users}, status: 200
		else
			response={message:"invalid credentials"}
			render json: response, status: 401
		end
	end
end
end