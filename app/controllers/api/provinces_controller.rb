class Api::ProvincesController < ApplicationController
  def index
    provinces = Province.all
    render json: provinces, each_serializer: ProvinceSerializer
  end
end
