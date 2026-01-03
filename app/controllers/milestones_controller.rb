class MilestonesController < ApplicationController
  before_action :set_profile, only: [ :index, :create ]
  before_action :set_milestone, only: [ :show, :update, :destroy ]

  def index
    milestones = @profile.milestones.order(occurred_at: :desc)
    render json: milestones
  end

  def create
    milestone = @profile.milestones.new(milestone_params)
    if milestone.save
      render json: milestone, status: :created
    else
      render json: { error: milestone.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: @milestone
  end

  def update
    if @milestone.update(milestone_params)
      render json: @milestone
    else
      render json: { error: @milestone.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @milestone.destroy
    head :no_content
  end

  private

  def set_profile
    @profile = Profile.find(params[:profile_id])
  end

  def set_milestone
    @milestone = Milestone.find(params[:id])
  end

  def milestone_params
    params.require(:milestone).permit(:title, :category, :occurred_at, :mood, :notes, :favorite, tags: [])
  end
end
