class StudentsController < ApplicationController


  def register
    # same as new
  end

  def show
    @student = Student.find(params[:id])
  end

  #equivalent of create
  def enroll
    @course_details = params[:student][:course]
    @bio = params[:student][:bio]
    @address = params[:student][:address]
    @needs = params[:student][:needs]
    @demo = params[:student][:demo]
    @enquiry = params[:student][:commit] == 'Enrollment' ? 0 : 1


    @student = StudentCourseDetail.enroll_student(@course_details, @bio, @address, @needs, @demo, @enquiry)
    respond_to do |format|
      if @student.present?
        format.html {redirect_to @student, notice: "student created with these details"}
      else
        format.html {render action: 'register'}
      end
    end
  end

  def search
    @students = StudentCourseDetail.search(params[:first_name], params[:last_name], params[:student_id])
  end
end
