class HabitsController < ApplicationController
  before_action :set_profile

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

  private
  def set_profile
    @profile = Profile.find(params[:profile_id])
  end

  def habit_params
    params.require(:habit).permit(:name, :description, :goal_type, :goal_value)
  end
end
