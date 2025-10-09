class HabitLogsController < ApplicationController
  def index
    habit = Habit.find(params[:habit_id])
    logs = habit.habit_logs
    render json: logs
  end

  def create
    habit = Habit.find(params[:habit_id])
    # Prevent logging if habit is already complete
    if habit.goal_value.present? && habit.completed
      render json: { error: 'Habit is already complete. No further logs allowed.' }, status: :forbidden
      return
    end

    log = habit.habit_logs.new(log_params)
    if log.save
      # Check if habit goal is met after saving log
      if habit.goal_value.present? && habit_goal_met?(habit)
        habit.update(completed: true, date_completed: Date.today)
      end
      render json: log, status: :created
    else
      render json: { error: log.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  private
  def log_params
    params.require(:habit_log).permit(:log_date, :notes, :amount)
  end

  # Helper to check if habit goal is met
  def habit_goal_met?(habit)
    # Example logic: compare sum of log amounts to goal_value
    # Adjust this logic based on your goal_type and goal_value
    goal_value = habit.goal_value.to_i
    total = habit.habit_logs.sum(:amount)
    total >= goal_value
  end
end
