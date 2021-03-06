require 'csv'
class CoursesController < ApplicationController

  def by_code
    @course = Course.by_matching_code(params[:code])
    respond_to do |format|
      format.json {render json: @course}
    end
  end

  def by_open_mode
    @course = Course.by_open_mode(params[:code])
    respond_to do |format|
      format.json {render json: @course}
    end
  end

  #get /towns/name/:name.json
  def by_town
    @courses = Course.by_town_id(params[:id])
    respond_to do |format|
      format.json {render json: @courses}
    end
  end

  #get /courses
  def index
    @courses = Course.search(params[:course_code], params[:town], params[:course_date])
  end

  #get /schedule
  def schedule
    @courses = Course.search_by_schedule(params[:course_start_date], params[:course_end_date], params[:state])
  end

  #get /status
  def status
    @courses = Course.search_process(params[:course_code], params[:course_status], params[:course_start_date], params[:course_end_date])
  end

  #get /proforma
  def proforma
    @course = Course.where(course_code: params[:course_code]).first
    @course_type = params[:course_type]
  end

  def print_proforma
    @course = Course.find(params[:id])
    @course_type = params[:course_type]
    respond_to do |format|
      format.csv { send_data @course.generate_proforma_csv(@course_type), filename: "proforma_#{@course.course_code}.csv"}
    end
  end

  def merge
    @course = Course.where(course_code: params[:course_code]).first
    @result_type = params[:result_type]
    @additional_module_type = params[:additional_module_type]
  end

  def generate_merge
    @course = Course.find(params[:id])
    @result_type = params[:result_type]
    @additional_module_type = params[:additional_module_type]
    respond_to do |format|
      format.csv { send_data @course.generate_merge_txt(@result_type, @additional_module_type), filename: "CHEMMERGE.txt"}
    end
  end

  def confirmation
    @course = Course.where(course_code: params[:course_code]).first
    @course_type = params[:course_type]
    @additional_module_type = params[:additional_module_type]
  end

  def generate_confirmation
    @course = Course.find(params[:id])
    @course_type = params[:course_type]
    @additional_module_type = params[:additional_module_type]
    respond_to do |format|
      format.csv { send_data @course.generate_confirmation_csv(@course_type, @additional_module_type), filename: "CHEMCONFIRMATIONMERGE.txt"}
    end
  end

  #get /course/1
  def show
    @course = Course.find(params[:id])
    respond_to do |format|
      format.html {render 'show'}
      format.json {render json: @course.to_json(include: :student_course_details)}
    end
  end

  #get /courses/new
  # need to change this to something ajax
  def new
    @course = Course.new
    @states = State.all
    @postals = PostalCode.all
    @towns = Town.all
  end

  #get /courses/1/edit
  def edit
    @course = Course.find(params[:id])
    @postal_code_selected = @course.location_relation.postal_code
    @state_selected = @course.location_relation.state
    @town_selected = @course.location_relation.town
    @course_code = @course.course_code
    @venue_selected = @course.try(:venue)
  end

  #get /courses/process
  def course_process
    @course = Course.search_for_processing(params[:course_code])
  end


  #post /courses/process
  def course_post_process
    result = CourseProcessDetail.create_process_detail(params[:course])
    p "-----> #{result}"
      if result[:success]
        flash[:notice] = "Course is closed"
        redirect_to process_courses_path(:course_code => params[:course][:course_code])
      else
        flash[:notice] = result[:error]
        render action: 'course_process'
      end
    end


  #post /courses
  def create
    state_id = params[:course][:state]
    town_id = params[:course][:town]
    postal_code_id = params[:course][:postal_code]
    location_relation_id = LocationRelation.where(:state_id => state_id, :postal_code_id => postal_code_id, :town_id => town_id).first
    course_code = params[:course][:course_code]
    @course = Course.new(:training_organization_id => params[:course][:training_organization],
      :is_correspondence => params[:course][:is_correspondence],
      :in_house_course => params[:course][:in_house_course],
      :in_house_course_name => params[:course][:in_house_course_name],
      :course_code => course_code,
      :course_date => params[:course][:course_date],
      :location_relation_id => location_relation_id.id,
      :venue_id => params[:course][:venue],
      :trainer_id => params[:course][:trainer],
      # creating all default courses with 1 - which is open.
      :course_status_id => 1
      )
      if @course.save
        redirect_to @course, notice: "rto was succesfully created."
      else
        flash["notice"] = @course.errors.full_messages
        render action: 'new'
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    @course = Course.find(params[:id])
    state_id = params[:course][:state]
    town_id = params[:course][:town]
    postal_code_id = params[:course][:postal_code]
    location_relation_id = LocationRelation.where(:state_id => state_id, :postal_code_id => postal_code_id, :town_id => town_id).first
    respond_to do |format|
      if @course.update(:training_organization_id => params[:course][:training_organization],
                     :is_correspondence => params[:course][:is_correspondence],
                     :is_correspondence => params[:course][:is_correspondence],
                     :in_house_course => params[:course][:in_house_course],
                     :course_code => params[:course][:course_code],
                     :course_date => params[:course][:course_date],
                     :location_relation_id => location_relation_id.id,
                     :venue_id => params[:course][:venue],
                     :trainer_id => params[:course][:trainer]
      )
        format.html { redirect_to @course, notice: 'RTO was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_rto
    @rto = TrainingOrganization.find(params[:id])
  end
end
