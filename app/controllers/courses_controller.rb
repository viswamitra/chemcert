require 'csv'
class CoursesController < ApplicationController

  def by_code
    @course = Course.by_matching_code(params[:code])
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
  end

  def print_proforma
    @course = Course.find(params[:id])
    respond_to do |format|
      format.csv { send_data @course.to_csv, filename: "proforma_#{@course.course_code}.csv"}
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
    @venue_selected = @course.location_relation.venue
  end

  #get /courses/process
  def course_process
    @course = Course.search_for_processing(params[:course_code])
  end


  #post /courses/process
  def course_post_process
    result = CourseProcessDetail.create_process_detail(params[:course])
      if result[:success]
        redirect_to process_courses_path
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
    course_code = params[:course][:course_code]+((Course.last.try(:id).present? ? Course.last.id : 0) +1).to_s
    @course = Course.new(:training_organization_id => params[:course][:training_organization],
      :is_correspondence => params[:course][:is_correspondence],
      :course_code => course_code,
      :course_date => params[:course][:course_date],
      :location_relation_id => location_relation_id.id,
      :venue_id => params[:course][:venue],
      :trainer_id => params[:course][:trainer]
      )
    respond_to do |format|
      if @course.save
        format.html {redirect_to @course, notice: "rto was succesfully created."}
        format.json {render action: 'show', status: :created, location: @rto}
      else
        format.html { render action: 'new' }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
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
