class Warehouse
  attr_accessor :id, :name, :code, :address, :description, :postal_code, :city, :state, :postal_code, :total_area, :useful_area
  def initialize(id:, name:, code:, address:, description:, city:, state:, postal_code:, total_area:, useful_area:)
    @id = id
    @name = name
    @code = code
    @address = address
    @description = description
    @city = city
    @state = state
    @postal_code = postal_code
    @total_area = total_area
    @useful_area = useful_area
  end

  def self.all
    response = Faraday.get("http://127.0.0.1:3000/api/v1/warehouses")
    result = []
    if response.status == 200
      warehouses = JSON.parse(response.body)
      warehouses.each do |w|
        result << Warehouse.new(id: w["id"], name: w["name"], code: w["code"], address: w["address"], description: w["description"], 
          city: w["city"], state: w["state"], postal_code: w["postal_code"], total_area: w["total_area"], useful_area: w["useful_area"])
      end
    else
      return nil
    end
    return result
  end

  def save(w)
    response = Faraday.post('http://127.0.0.1:3000/api/v1/warehouses') do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = {"name": w.name,
        "code": w.code,
        "description": w.description,
        "address": w.address,
        "city": w.city,
        "state": w.state,
        "postal_code": w.postal_code,
        "total_area": w.total_area,
        "useful_area": w.useful_area,
        "category_ids": 1}.to_json
      end

    if response.status == 201
      return true
    end
    return false
  end
end