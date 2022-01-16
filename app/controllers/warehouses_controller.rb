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

  def new
  end

  def create
    @warehouse = Warehouse.new(id: params[:id], name: params[:name], code: params[:code], address: params[:address], description: params[:description],
                  city: params[:city], state: params[:state], postal_code: params[:postal_code], total_area: params[:total_area], useful_area: params[:useful_area])
  
    if @warehouse.save(@warehouse)
        redirect_to root_path, notice: 'Galpão registrado com sucesso'
    else
      flash[:alert] = 'Não foi possível gravar o galpão'
      render 'new'
    end        
  end
end