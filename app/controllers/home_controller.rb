class HomeController < ApplicationController
  def index
    @warehouses = Warehouse.all

    if @warehouses.nil?
      flash.now['alert'] = 'Não foi possível acessar o banco de dados dos galpões'
    end
  end
end