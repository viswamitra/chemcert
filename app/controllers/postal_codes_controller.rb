class PostalCodesController < ApplicationController

  #get /postal_codes/code/:code.json
  def by_code
    @postal_code = PostalCode.by_matching_code(params[:code])
    respond_to do |format|
      format.json {render json: @postal_code}
    end
  end

end
