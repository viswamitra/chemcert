class StudentsController < ApplicationController


  def register


  end

  def enroll
    @students = params[:student]
    render text: @students
    @student = Student
  end
end
