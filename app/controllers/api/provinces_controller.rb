class Api::ProvincesController < ApplicationController
  def index
    provinces = Province.eager_load(:region).all
    render json: provinces, each_serializer: ProvinceSerializer
  end
end
