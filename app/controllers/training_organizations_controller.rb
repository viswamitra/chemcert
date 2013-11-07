class TrainingOrganizationsController < ApplicationController

  #get /rtos
  def index
    @rtos = TrainingOrganization.all
  end

  #get /rtos/1
  def show
    @rto = TrainingOrganization.find(params[:id])
  end


  #get /rtos/new
  def new
    @rto = TrainingOrganization.new
  end

  #post /rto
  def create
    @rto = TrainingOrganization.new(training_organization_params)

    respond_to do |format|
      if @rto.save
        format.html {redirect_to @rto, notice: "rto was succesfully created."}
        format.json {render action: 'show', status: :created, location: @rto}
      else

      end
    end
  end

end
