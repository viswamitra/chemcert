class CoursesController < ApplicationController

  #get /courses
  def index
    @courses = Course.all
  end

  #get /course/1
  def show
    @course = Course.find(params[:id])
  end


  #get /courses/new
  def new
    @course = Course.new
    @states = State.all
  end

  #get /courses/1/edit
  def edit
    @course = Course.find(params[:id])
  end

  #post /courses
  def create
    @course = Course.new(course_params)
    respond_to do |format|
      if @rto.save
        format.html {redirect_to @rto, notice: "rto was succesfully created."}
        format.json {render action: 'show', status: :created, location: @rto}
      else
        format.html { render action: 'new' }
        format.json { render json: @rto.errors, status: :unprocessable_entity }
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
  def rto_params
    params.require(:training_organization).permit(:name, :provider)
  end
end
