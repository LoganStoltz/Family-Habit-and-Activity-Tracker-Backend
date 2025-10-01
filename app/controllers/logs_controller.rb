class LogsController < ApplicationController
  def index
    habit = Habit.find(params[:habit_id])
    logs = habit.logs
    render json: logs
  end
end
