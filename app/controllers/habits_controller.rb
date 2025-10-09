class HabitsController < ApplicationController
  before_action :set_profile, :current_user, only: [:index, :create]

  def update
    habit = Habit.find(params[:id])
    if habit.update(habit_params)
      render json: habit
    else
      render json: { error: habit.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    habits = @profile.habits
    render json: habits
  end

  def create
    habit = @profile.habits.new(habit_params)
    if habit.save
      render json: habit, status: :created
    else
      render json: { error: habit.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def destroy
  habit = Habit.find_by(id: params[:id])
  if habit
    habit.destroy
    render json: { success: true }
  else
    render json: { error: "Habit not found" }, status: :not_found
  end
end

  private
  def set_profile
    @profile = Profile.find(params[:profile_id])
  end

  def current_user
    @current_user ||= User.find(params[:user_id])
  end

  def habit_params
    params.require(:habit).permit(:name, :description, :goal_type, :goal_value)
  end
end
