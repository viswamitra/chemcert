class StudentsController < ApplicationController


  def register
    # same as new
  end

  #equivalent of create
  def enroll
    @course_details = params[:student][:course]
    @bio = params[:student][:bio]
    @address = params[:student][:address]
    @needs = params[:student][:needs]
    @demo = params[:student][:demo]

    result = StudentCourseDetail.enroll_student(@course_details, @bio, @address, @needs, @demo)
    respond_to do |format|
      if result
        format.html {redirect_to @course, notice: "student created with these details"}
      else
        format.html {render action: 'register'}
      end
    end
  end

  def search
    @students = StudentCourseDetail.search(params[:first_name], params[:last_name], params[:student_id])
  end
end
