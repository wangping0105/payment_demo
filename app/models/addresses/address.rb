class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true
  belongs_to :country, required: false
  belongs_to :province, required: false
  belongs_to :city, required: false
  belongs_to :district, required: false

  extend Geocoder::Model::ActiveRecord unless defined? Rails::Railtie
  geocoded_by :detail_address, :latitude  => :lat, :longitude => :lng


  enum sub_type: {default: 1, nomal: 0}
  GAODE_KEY = '3760f57b71e2a01d43645f2a00940567'

  delegate :provinces_names, :cities_names, to: "self.class"

  before_save do
    if changes[:detail_address].present?
      convert_detail_address_to_lat_lng
    end
  end

  # 转化百度的to高德
  def convert_baidu_lat_lng_to_gaode(skip_save = true)
    begin
      params = {
        coordsys: 'baidu',
        key: GAODE_KEY,
        locations: [self.lon, self.lat].join(','),
        output: 'json'
      }
      url = "http://restapi.gaode.com/v3/assistant/coordinate/convert"

      response = HTTParty.get(url+"?#{params.to_param}")
      if response['status'] == '1'
        lon, lat = response['locations'].split(',')
        skip_save ? self.assign_attributes(lat: lat, lon: lon) : self.update(lat: lat, lon: lon)
      end
    rescue        address.convert_detail_address_to_lat_lng
    end
  end

  # http://restapi.amap.com/v3/geocode/geo?key=cf39121612963d8386d23e3ea7cfabec&s=rsv3&city=%E5%AE%81%E5%BE%B7%E5%B8%82&address=%E7%A6%8F%E5%BB%BA%E7%9C%81%E9%9C%9E%E6%B5%A6%E5%8E%BF%E6%B0%B4%E9%97%A8%E7%95%B2%E6%97%8F%E4%B9%A1
  def convert_detail_address_to_lat_lng(skip_save = true)
    begin
      if detail_address.blank?
        lng, lat  = nil, nil
        return skip_save ? self.assign_attributes(lat: lat, lng: lng) : self.update(lat: lat, lng: lng)
      end

      params = {
        key: GAODE_KEY,
        address: detail_address,
        output: 'json'
      }
      uri = URI "http://restapi.amap.com/v3/geocode/geo"

      params.merge!(city: "#{city}") if city.present?
      params.merge!(province: "#{province}") if province.present?

      if params[:city].blank?
        _city = cities_names.detect{|_name| detail_address.start_with?(_name) }
        params.merge!(city: "#{_city}") if _city.present?
      end
      if params[:province].blank?
        _province = provinces_names.detect{|_name| detail_address.start_with?(_name) }
        params.merge!(province: "#{province}") if province.present?
      end

      uri.query = params.to_query
      response = HTTParty.get("#{uri}")
      lng, lat  = nil, nil
      if response['status'] == '1' and response['geocodes'].present?
        lng, lat  = response['geocodes'][0]['location'].split(",")
      else
        uri.query = params.except(:city, :province).merge(address: detail_address).to_query
        response = HTTParty.get("#{uri}")

        if response['status'] == '1' and response['geocodes'].present?
          lng, lat  = response['geocodes'][0]['location'].split(",")
        else
          puts "get lat,lng fail: #{response}"
        end
      end

      skip_save ? self.assign_attributes(lat: lat, lng: lng) : self.update(lat: lat, lng: lng)

      [lat, lng]
    rescue
      puts "get lat,lng error: #{detail_address}"
    end
  end

  class << self
    def cities_names
      @_cities_names ||= City.pluck(:name)
    end

    def provinces_names
      @_provinces_names ||= Province.pluck(:name)
    end
  end
end