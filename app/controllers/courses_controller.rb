class CoursesController < ApplicationController

  #get /courses
  def index
    @courses = Course.search(params[:course_code], params[:town], params[:course_date])
  end

  #get /course/1
  def show
    @course = Course.find(params[:id])
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
    @states = State.all
    @postals = PostalCode.all
    @towns = Town.all
    @postal_code_selected = @course.location_relation.postal_code
    @state_selected = @course.location_relation.state
    @town_selected = @course.location_relation.town
  end

  #post /courses
  def create
    state_id = params[:course][:state]
    town_id = params[:course][:town]
    postal_code_id = params[:course][:postal_code]
    location_relation_id = LocationRelation.where(:state_id => state_id, :postal_code_id => postal_code_id, :town_id => town_id).first
    @course = Course.new(:training_organization_id => params[:course][:training_organization],
      :is_correspondence => params[:course][:is_correspondence],
      :course_code => params[:course][:course_code],
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
    @rto = TrainingOrganization.find(params[:id])
    respond_to do |format|
      if @rto.update(rto_params)
        format.html { redirect_to @rto, notice: 'RTO was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @rto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  def destroy
    @rto = TrainingOrganization.find(params[:id])
    @rto.destroy
    respond_to do |format|
      format.html { redirect_to training_organizations_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_rto
    @rto = TrainingOrganization.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
end
