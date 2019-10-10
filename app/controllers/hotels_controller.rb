class HotelsController < ApplicationController

def index
  if !params[:email].present?
    render json: {message:"provide email address for authentication"}, status: 406

  else
	   user =User.find_by(email:params[:email])
	   if user && user.authenticate(params[:password])
	     @hotels=Hotel.all
       render json: {hotels: @hotels}, status: 200
     else
    	 response ={message: 'invalid credentials'}
    	 render json: response, status: 401
    end
  end

end
def address
  if !params[:email].present?
      render json: {message:"provide email address for authentication"}, status: 406
  elsif !params[:address].present?
      render json: {message:"provide a address"}, status: 406
  else
      user=User.find_by(email:params[:email])
      if user && user.authenticate(params[:password])
   	    @hotels=Hotel.where(hotel_address: params[:address])
        render json: {address:params[:address], hotels: @hotels}
      else
   	    response={message: 'invalid credentials'}
   	    render json: response, status: 401
      end
  end
end
def create
   @hotel=Hotel.new(hotel_name: params[:hotelname],hotel_address:params[:address], hotel_rating:params[:hotelraiting])
   if @hotel.save
   	response={message: 'hotel created'}
   	render json: response , status: 201
   else
   		response={message: @hotel.errors.full_messages}
   		render json: response, status: :bad
   end

end
private 
def user_params
params.permit(:hotel_address,:hotel_name,:hotel_rating)
end

end
