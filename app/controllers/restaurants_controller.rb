class RestaurantsController < ApplicationController
  before_filter :authorize

  def index
    # check redis database for already exist records corresponding to usr id
    # if available show it send those to UI
    # if not stroe Restaurant.restaurants's result into redis correspoind to usr id
    # render json: Restaurant.restaurants

    logger.info "======exist status======#{current_user.exist_records?}"

    if current_user.exist_records?
      @restaurants = current_user.get_records
    else
      current_user.set_records Zomoto.new(current_user.city).restaurants
      @restaurants = current_user.get_records
    end
  end
end
