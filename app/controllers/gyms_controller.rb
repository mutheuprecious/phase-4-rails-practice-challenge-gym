class GymsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    render json: Gym.all, status: :ok
  end

  def create
    gym = Gym.create(allowed_gym_params)
    render json: gym, status: :created
  end

  def show
    gym = find_gym
    render json: gym, status: :created
  end

  def update
    gym = find_gym
    gym.update(allowed_gym_params)
    render json: gym, status: :created
  end

  def destroy
    gym = find_gym
    gym.destroy
    head :no_content
  end

  private

  def find_gym
    Gym.find(params[:id])
  end

  def allowed_gym_params
    params.permit(:name, :address)
  end

  def record_not_found
    render json: {errors: "Gym not found"}, status: :not_found
  end
end
