class HabitLogsController < ApplicationController
  def index
    habit = Habit.find(params[:habit_id])
    logs = habit.habit_logs
    render json: logs
  end

  def create
    habit = Habit.find(params[:habit_id])

    log = habit.habit_logs.new(log_params)
    if log.save
      render json: log, status: :created
    else
      render json: { error: log.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  private
  def log_params
    params.require(:habit_log).permit(:habit_id, :profile_id, :log_date, :notes, extra_data: {})
  end
end
