class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_entry

    def index
        instructors = Instructor.all
        render json: instructors, status: :ok
    end

    def show
        instructor = Instructor.find(params[:id])
        render json: instructor, status: :ok
    end

    def create
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created
    end

    def destroy
        instructor = Instructor.find(params[:id])
        instructor.destroy
        head :no_content
    end


    private

    def instructor_params
        params.permit(:name)
    end

    def record_not_found
        render json: {errors: "Record Not Found"}, status: :not_found
    end

    def invalid_entry(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
