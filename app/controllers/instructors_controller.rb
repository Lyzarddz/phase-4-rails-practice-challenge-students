class InstructorsController < ApplicationController

rescue_from ActiveRecord::RecordNotFound, with :render_not_found
rescue_from ActiveRecord::RecordInvalid, with :render_invalid

    def index 
        instructors = Instructor.All 
        render json: instructors, status: :ok
    end

    def show
        instructor= Instructor.find(params[:id])
        render json: instructor, status: :ok
    end

    def create 
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created
    end

    def updated 
        instructor =Instructor.find(params[:id])
        instructor.update!(instructor_params)
        render json: instructor, status: :created
    end

    def destroy
        instructor= Instructor.find(params[:id])
        instructor.destroy
        render json: {}, status: :no_content
    end

    private

    def instructor_params
        params.permit(:name)
    end

    def render_not_found
        render json: {error: "Instructor Not Found"} status: :not_found
    end

    def render_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
    end
