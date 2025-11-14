# app/controllers/profiles_controller.rb
class ProfilesController < ApplicationController
  before_action :set_user
  before_action :set_profile, only: [ :show, :update, :destroy ]

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
      default_habits = case profile.profile_type
      when "Baby"
          [
            { name: "Diaper Change", description: "Change diaper", category: "diaperChange" },
            { name: "Feeding", description: "Feed baby", category: "feeding" },
            { name: "Bathe", description: "Bathe baby", category: "babyBath" },
            { name: "Nap", description: "Nap time", category: "sleeping" }
          ]
      when "Adult"
          [
            { name: "Drink Water", description: "Stay hydrated", category: "drinkingWater" },
            { name: "Exercise", description: "Physical activity", category: "exercise" },
            { name: "Meals", description: "Full meals", category: "meals" }
          ]
      else
          []
      end
      habit_errors = []
      default_habits.each do |habit_attrs|
        habit = profile.habits.create(habit_attrs)
        unless habit.persisted?
          habit_errors << habit.errors.full_messages
          Rails.logger.error "Failed to create habit: #{habit_attrs[:name]} - #{habit.errors.full_messages.join(', ')}"
        end
      end
      if habit_errors.any?
        render json: { profile: profile, habit_errors: habit_errors }, status: :created
      else
        render json: { profile: profile }, status: :created
      end
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
    params.require(:profile).permit(:user_id, :first_name, :last_name, :user_name, :dob, :profile_type)
  end
end
