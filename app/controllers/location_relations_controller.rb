class LocationRelationsController < ApplicationController

  #get /towns/name/:name.json
  def by_postal_code
    @location_relation = LocationRelation.by_postal_code(params[:postal_code])
    respond_to do |format|
      format.json {render json: @location_relation}
    end
  end

end
