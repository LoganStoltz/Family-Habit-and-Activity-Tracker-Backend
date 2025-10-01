# app/controllers/profiles_controller.rb
class ProfilesController < ApplicationController
  before_action :set_user
  before_action :set_profile, only: [:show, :update, :destroy]

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

  def update
    if @profile.update(profile_params)
      render json: @profile, status: :ok
    else
      render json: { errors: @profile.errors.full_messages }, status: :unprocessable_entity
    end
  end


  def destroy
    if @profile.destroy
      head :no_content  # respond with 204 No Content
    else
      render json: { error: "Failed to delete profile" }, status: :unprocessable_entity
    end
  end

  
  private
  def set_profile
    @profile = @user.profiles.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def profile_params
    params.require(:profile).permit(:user_id,:first_name, :last_name, :user_name, :dob, :profile_type)
  end
end
