class StudentsController < ApplicationController


  def register


  end

  def enroll
    @course_details = params[:student][:course]
    @bio = params[:student][:bio]
    @address = params[:student][:address]
    @needs = params[:student][:needs]
    @demo = params[:student][:demo]

    result = StudentCourseDetail.enroll_student(@course_details, @bio, @address, @needs, @demo)

    if result
      #render blah blah
    end
    render text: @students
    #student_biodata
    #first_name =
  end
end
