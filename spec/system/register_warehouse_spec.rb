require 'rails_helper'

describe 'Register Warehouse' do
  it 'through a request in a form' do
    # Arrange
    warehouse = File.read(Rails.root.join('spec', 'support', 'api_resources', 'warehouse.json'))
    response = Faraday::Response.new(status: 201, response_body: warehouse)
    allow(Faraday).to receive(:post).and_return(response)

    # Act
    visit root_path
    click_on 'Cadastrar Galpão'
    fill_in 'Nome', with: 'Guarulhos'
    fill_in 'Código', with: 'GRU'
    fill_in 'Endereço', with: 'Praça 9'
    fill_in 'Descrição', with: 'Ótimo galpão numa linda cidade'
    fill_in 'Cidade', with: 'Guarulhos'
    fill_in 'Estado', with: 'SP'
    fill_in 'CEP', with: '09950-000'
    fill_in 'Área Total', with: '10000'
    fill_in 'Área Útil', with: '8000'
    click_on 'Gravar'
    click_on 'Guarulhos'

    # Assert
    expect(page).to have_content 'Guarulhos'
    expect(page).to have_content 'GRU'
    expect(page).to have_content 'Praça 9'
    expect(page).to have_content 'Ótimo galpão numa linda cidade'
  end
end