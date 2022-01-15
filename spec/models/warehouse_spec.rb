require 'rails_helper'

describe Warehouse do
  context '.all' do
    it 'should return all warehouses' do
      # Arrange
      warehouses_data = File.read(Rails.root.join('spec', 'support', 'api_resources', 'warehouses.json'))
      response = Faraday::Response.new(status: 200, response_body: warehouses_data)
      allow(Faraday).to receive(:get).with('http://127.0.0.1:3000/api/v1/warehouses')
                                     .and_return(response)
      # Act
      result = Warehouse.all

      # Assert
      expect(result.length).to eq 2
      expect(result.first.name).to eq 'Guarulhos'
      expect(result.first.code).to eq 'GRU'
      expect(result.last.name).to eq 'Salvador'
    end

    it 'should return empty if theres no warehouse' do
      response = Faraday::Response.new(status: 200, response_body: '[]')
      allow(Faraday).to receive(:get).with('http://127.0.0.1:3000/api/v1/warehouses')
                                     .and_return(response)
      # Act
      result = Warehouse.all

      # Assert
      expect(result).to eq []
    end

    it 'should return nil if API is unavailable' do
      
      response = Faraday::Response.new(status: 500, response_body: '{}')
      allow(Faraday).to receive(:get).with('http://127.0.0.1:3000/api/v1/warehouses')
                                     .and_return(response)
      # Act
      result = Warehouse.all

      # Assert
      expect(result).to eq nil
    end

    it 'should return nil if API is unavailable' do
      
      response = Faraday::Response.new(status: 500, response_body: '{}')
      allow(Faraday).to receive(:get).with('http://127.0.0.1:3000/api/v1/warehouses')
                                     .and_return(response)
      # Act
      result = Warehouse.all

      # Assert
      expect(result).to eq nil
    end

  end
end
