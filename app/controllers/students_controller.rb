class StudentsController < ApplicationController


  def register


  end

  def enroll


    @course_details = params[:student][:course]
    @bio = params[:student][:bio]


    render text: @students

    @student = StudentCourse.enroll_student(@course_details, @bio)


    student_id = StudentCourse.create_new_student_id
    @student_course = StudentCourseDetail.new(:student_id => student_id,
    :student_course_id => @student_course["course_types"],
    :addition_module_id => @student_course["additional_modules"],
    :enrolled_at => @student_course["enrolled_at"],
    )

    #student_biodata
    #first_name =
  end
end
