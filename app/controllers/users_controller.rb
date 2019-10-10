# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    if !params[:email].present?
      render json: { message: 'provide username and password for authentication' }, status: 406
    else
      user = User.find_by(email: params[:email])
      if user&.authenticate(params[:password])
        @users = User.all
        # render json:{users:@users}, status: 200
      else
        response = { message: 'invalid credentials' }
        render json: response, status: 401
      end
    end
  end

  def create
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.save

      render json: { message: 'user successfully created' }, status: 201
    else
      render json: { message: @user.errors.full_messages }, status: 422
    end
  end
end
