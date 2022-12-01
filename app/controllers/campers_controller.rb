class CampersController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found

def index 
    campers = Camper.all
    render json: campers, status: :ok
end

def show
    camper = Camper.find(params[:id])
    render json: camper, serializer: SingleCamperSerializer
end

def create
    camper = Camper.create!(camper_params)
    render json: camper, status: :created
end

private
def render_unprocessable_entity(invalid)
    render json: { errors: invalid.record.errors.full_messages  }, status: :unprocessable_entity
end

def render_record_not_found
    render json: { error: "Camper not found" }, status: :not_found
end

def camper_params
    params.permit(:name, :age)
end


end
