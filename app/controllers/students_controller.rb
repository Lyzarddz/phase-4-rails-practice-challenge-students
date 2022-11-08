class StudentsController < ApplicationController

rescue_from ActiveRecord::RecordNotFound, with :render_not_found
rescue_from ActiveRecord::RecordInvalid, with :render_invalid

def index 
    students= Student.all 
    render json: students, status: :ok
end

def show 
    student= Student.find(params[:id])
    render json: student, status: :ok
end

def create
    student= Student.create!(student_params)
    render json: student, status: :created
end

def update
    student =Student.find(params[:id])
    student.update!(student_params)
     render json: student, status: :updated
end

def destroy
    student = Student.find(params[:id])
    student.destroy
    render json: {}, status: :no_content
end


private

def student_params
    params.permit(:name, :age, :major, :instructor_id)
end

def render_not_found
    render json: {error: "Student Not Found"} status: :not_found
end

def render_invalid(invalid)
    render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
end
end
