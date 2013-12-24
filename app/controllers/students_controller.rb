class StudentsController < ApplicationController

  def register
    # same as new
  end

  def show
    @student = Student.find(params[:id])
  end

  def edit
    @student = Student.find(params[:id])
    @course = @student.student_course_detail.course
    @from_process = params[:from_process]
  end

  #equivalent of create
  def enroll
    @course_details = params[:student][:course]
    @bio = params[:student][:bio]
    @address = params[:student][:address]
    @needs = params[:student][:needs]
    @demo = params[:student][:demo]
    @enquiry = params[:commit] == 'Enrollment' ? 1 : 0

    @student = StudentCourseDetail.enroll_student(@course_details, @bio, @address, @needs, @demo, @enquiry)
    respond_to do |format|
      if @student.present?
        format.html {redirect_to @student, notice: "student created with these details"}
      else
        format.html {render action: 'register'}
      end
    end
  end

  #PATCH/PUT students/update
  def update
    @student_id = params[:student][:student_id]
    @course_details = params[:student][:course]
    @bio = params[:student][:bio]
    @address = params[:student][:address]
    @needs = params[:student][:needs]
    @demo = params[:student][:demo]

    @student = StudentCourseDetail.update_student(@student_id, @course_details, @bio, @address, @needs, @demo)
    respond_to do |format|
      if @student.present?

        format.html {redirect_to @student, notice: "student created/updated with these details"}
      else
        flash["notice"] = "something went wrong, try again."
        format.html {render action: 'register'}
      end
    end
    # here update the student attributes
  end

  def search
    @students = Student.search(params[:first_name], params[:last_name], params[:student_id], params[:enquiry], params[:state])
  end
end
