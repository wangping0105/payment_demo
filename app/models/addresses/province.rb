class Province < ActiveRecord::Base
  belongs_to :country

  has_many :cities

  def self.all_with_cities_and_districts
    cities = City.select_json(:id, :name, :province_id).group_by { |h| h['province_id'] }
    districts = District.select_json(:id, :name, :city_id).group_by { |h| h['city_id'] }
    Province.select_json(:id, :name).each do |province|
      province['sub'] = Array(cities[province['id']]).each do |city|
        city.delete('province_id')
        city['sub'] = Array(districts[city['id']]).each { |district| district.delete('city_id') }
      end
    end
  end

  def to_s
    name || id
  end
end
