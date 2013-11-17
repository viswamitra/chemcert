class TownsController < ApplicationController

  #get /towns/name/:name.json
  def by_name
    @town = Town.by_matching_name(params[:name])
    respond_to do |format|
      format.json {render json: @town}
    end
  end
end
