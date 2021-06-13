class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_json_error
    def index 
        campers = Camper.all 
        render json: campers 
    end

    def show
        camper = Camper.find(params[:id])
        render json: camper
    end

    def create 
      camper = Camper.create!(camper_params)
      render json: camper, status: :created
    end



    private 

    def camper_params
        params.permit(:name, :age)
        # params.require(:camper).permit(:name, :age)
    end

    def render_not_found_response
        render json: { error: "Camper not found" }, status: :not_found
      end

    def render_json_error
        render json: {
            "errors": ["validation errors"]
          }, status: :unprocessable_entity
    end

end
