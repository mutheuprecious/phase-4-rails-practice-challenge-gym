class ClientsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
    def index
      render json: Client.all, status: :ok
    end
  
    def create
      client = Client.create(allowed_client_params)
      render json: client, status: :created
    end
  
    def show
      client = find_client
      render json: client, status: :created
    end
  
    def update
      client = find_client
      client.update(allowed_client_params)
      render json: client, status: :created
    end
  
    private
  
    def find_client
      Client.find(params[:id])
    end
  
    def allowed_client_params
      params.permit(:name, :age)
    end
  
    def record_not_found
      render json: {errors: "Record not found"}, status: :not_found
    end
end
