class MembershipsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :not_allowed
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    render json: Membership.all, status: :ok
  end

  def create
    client = Client.find(params[:client_id])
    membership = client.memberships.create!(allowed_params)
    render json: membership, status: :created
  end

  private

  def allowed_params
    params.permit(:gym_id,:charge)
  end

  def not_allowed
    render json: {errors: "A client can not have two memberships in one gym"}, status: :unprocessable_entity
  end

  def record_not_found
    render json: {errors: "User does not exist"}, status: :not_found
  end
end
