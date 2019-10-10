class CommentsController < ApplicationController
   def index
    #byebug
    if(!params[:email].present?)
         response = {message: 'provide email address for authentication'}
         render json: response, status: 406
   
    else


   	      user=User.find_by(email: params[:email].downcase)
          #response={email:params[:email], password: params[:password]}
          # render json: response, status: 200
          #byebug
          if user && user.authenticate(params[:password])
      
      
            @comments =Comment.all
            render json: {comment: @comments}, status: 200
      
          else
     	      response = {message: 'login unsuccessfully'}
		        render json: response, status: 401
	         end
      end

   end

   def user
    
      if(!params[:email].present?)
          render json: {message:"provide email address for authentication"}, status: 406
       
       else

         
        if  !params[:useremail].present?
          render json:{message:"provide user's email id to fetch his comments"}, status: 406
        else
   	        user=User.find_by(email: params[:email].downcase)

            if user && user.authenticate(params[:password])
     	        @u=User.find_by(email: params[:useremail].downcase)
     	        if @u.present?
     	           @comments=@u.comments
                  render json: {useremail: params[:useremail], comments:@comments}, status:200
     	        else
                render json:{message:"user not found"}, stauts: 404
              end
            else
              response = {message: 'invalid credentials'}
		          render json: response, status: 401
            end
        end
      end

   end
   def hotel
        if !params[:email].present?
            render json: {message:"provide email address for authentication"}, status: 406
        else
            user=User.find_by(email:params[:email].downcase)
            if user && user.authenticate(params[:password])
              @hotel=Hotel.find_by(hotel_name:params[:hotelname], hotel_address:params[:address])
              if(!@hotel.present?)
              render json: {message:"hotel not found"}, status: 404
              else

              @comments= @hotel.comments
              render json: {hotel_name:params[:hotelname], hotel_address:params[:address],comments: @comments}, status: 200
              end
            else
            response={message: 'invalid credentials'}
            render json: response, status: 401
            end
        end
   end


end