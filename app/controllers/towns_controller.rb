class TownsController < ApplicationController

  #get /towns/name/:name.json
  def by_name
    @towns = Town.by_matching_name(params[:name])
    respond_to do |format|
      format.json {render json: @towns}
    end
  end

  #get /towns/by_state/:id.json
  def by_state
    @towns = Town.by_state(params[:id])
    respond_to do |format|
      format.json {render json:@towns}
    end
  end
end
