# frozen_string_literal: true

class UsersController < ApplicationController
  
  def index
    user = User.find_by(email: params[:email])
    @users = User.all
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
