class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_entry

    def index
        students = Student.all
        render json: students, status: :ok
    end

    def show
        student = Student.find(params[:id])
        render json: student, status: :ok
    end

    def create
        student = Student.create!(student_params)
        render json: student, status: :created
    end

    def destroy
        student = Student.find(params[:id])
        student.destroy
        head :no_content
    end

    private

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end

    def record_not_found
        render json: {errors: "Record not found"}, status: :not_found
    end

    def invalid_entry(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
