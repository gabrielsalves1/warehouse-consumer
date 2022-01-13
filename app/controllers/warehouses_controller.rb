class WarehousesController < ApplicationController
  def show
    response = Faraday.get("http://127.0.0.1:3000/api/v1/warehouses/#{params[:id]}")
    @warehouse = []
    if response.status == 200
      @warehouse = JSON.parse(response.body)
    else
      flash.now[:alert] = 'Não foi possível carregar dados dos galpões'
    end
  end
end