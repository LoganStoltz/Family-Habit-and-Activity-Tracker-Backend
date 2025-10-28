class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email]) || User.find_by(user_name: params[:user_name])
    if user && user.authenticate(params[:password])
      render json: { user: user }, status: :ok
    else
      render json: { errors: [ "Invalid email/username or password" ] }, status: :unauthorized
    end
  end
end
