# app/controllers/profiles_controller.rb
class ProfilesController < ApplicationController
  before_action :set_user

  def index
    render json: @user.profiles 
  end

  def show
    profile = @user.profiles.find(params[:id])
    render json: { profile: profile }
  end

  def create
    profile = @user.profiles.new(profile_params)
    if profile.save
      render json: { profile: profile }, status: :created
    else
      render json: { errors: profile.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def set_user
    @user = User.find(params[:user_id])
  end

  def profile_params
    params.require(:profile).permit(:user_id,:first_name, :last_name, :user_name, :dob, :type)
  end
end
