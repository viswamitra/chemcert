class TrainersController < ApplicationController
  #get /rtos
  def index
    @trainers = Trainer.all.paginate(page: params[:page], per_page: 10)
  end

  #get /rtos/1
  def show
    @trainer = Trainer.find(params[:id])
  end

  #get /rtos/new
  def new
    @trainer = Trainer.new
  end

  #get /rtos/1/edit
  def edit
    @trainer = Trainer.find(params[:id])
  end

  #post /rto
  def create
    @trainer = TrainingOrganization.new(rto_params)
    respond_to do |format|
      if @trainer.save
        format.html {redirect_to @trainer, notice: "rto was succesfully created."}
        format.json {render action: 'show', status: :created, location: @trainer}
      else
        flash[:error] = @trainer.errors.full_messages
        p "-------> #{flash[:error]}"
        format.html { render action: 'new' }
        format.json { render json: @trainer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    @trainer = TrainingOrganization.find(params[:id])
    p rto_params
    respond_to do |format|
      if @trainer.update(rto_params)
        format.html { redirect_to @trainer, notice: 'RTO was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @trainer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  def destroy
    @trainer = TrainingOrganization.find(params[:id])
    @trainer.destroy
    respond_to do |format|
      format.html { redirect_to training_organizations_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_rto
    @rto = Trainer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def rto_params
    params.require(:trainer).permit(:name, :provider)
  end

end
