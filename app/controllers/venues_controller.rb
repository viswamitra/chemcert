class VenuesController < ApplicationController

  #get /venues
  def index
    @venues = Venue.all.paginate(page: params[:page], per_page: 10)
  end

  #get /venues/1
  def show
    @venue = Venue.find(params[:id])
  end


  #get /venues/new
  def new
    @venue = Venue.new
  end

  #get /venues/1/edit
  def edit
    @venue = Venue.find(params[:id])
    @postal_code_selected = @venue.location_relation.postal_code
    @state_selected = @venue.location_relation.state
    @town_selected = @venue.location_relation.town
  end

  #post /venue
  def create
    state_id = params[:venue][:state]
    town_id = params[:venue][:town]
    postal_code_id = params[:venue][:postal_code]
    location_relation = LocationRelation.where(:state_id => state_id, :postal_code_id => postal_code_id, :town_id => town_id).first
    @venue = Venue.new(
      :name => params[:venue][:name],
      :address => params[:venue][:address],
      :location_relation_id => location_relation.id,
      :room_name => params[:venue][:room_name],
      :room_cost => params[:venue][:room_cost],
      :room_setup => params[:venue][:room_setup],
      :capacity => params[:venue][:capacity],
      :screen => params[:venue][:screen],
      :whiteboard_available => params[:venue][:whiteboard_available],
      :catering => params[:venue][:catering],
      :lunch_available => params[:venue][:lunch],
      :notes => params[:venue][:notes]
    )

    respond_to do |format|
      if @venue.save
        format.html {redirect_to @venue, notice: "venue was succesfully created."}
        format.json {render action: 'show', status: :created, location: @venue}
      else
        format.html { render action: 'new' }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    @venue = Venue.find(params[:id])
    respond_to do |format|
      if @venue.update(rto_params)
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
