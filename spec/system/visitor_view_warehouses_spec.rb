require 'rails_helper'

describe 'Visitor view warehouses' do
  it 'on home page' do
    # Arrange
    warehouses = File.read(Rails.root.join('spec', 'support', 'api_resources', 'warehouses.json'))
    r = Faraday::Response.new(status: 200, response_body: warehouses)
    allow(Faraday).to receive(:get).with('http://127.0.0.1:3000/api/v1/warehouses').and_return(r)

    # Act
    visit root_path

    # Assert
    expect(page).to have_content 'Guarulhos'
    expect(page).to have_content 'GRU'

    expect(page).to have_content 'Salvador'
    expect(page).to have_content 'SSA'
  end

  it 'and theres no warehouses' do
    # Arrange
    r = Faraday::Response.new(status: 200, response_body: '[]')
    allow(Faraday).to receive(:get).with('http://127.0.0.1:3000/api/v1/warehouses').and_return(r)

    # Act
    visit root_path

    # Assert
    expect(page).to have_content 'Nenhum galpão disponível'
  end

  it 'and render an error message if API is unavailable' do
    # Arrange
    r = Faraday::Response.new(status: 503, response_body: '{}')
    allow(Faraday).to receive(:get).with('http://127.0.0.1:3000/api/v1/warehouses').and_return(r)

    # Act
    visit root_path

    # Assert
    expect(page).to have_content('Não foi possível acessar o banco de dados dos galpões')
  end
end