class CitiesController < ApplicationController
  skip_before_action :authenticate_user!

  def get_cities_by_state
    @cities = City.where("state_id = ?", params[:state_id])
    render json: @cities
  end

  def list
    cities = City.where(state_id: params[:state_id])
    render json: cities
  end

  def get_by_name
    @cities = City.where('lower(name) LIKE ?', "%#{params[:term].downcase}%")
    render json: @cities
  end
end
