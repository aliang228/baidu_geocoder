require "baidu_geocoder/version"
require 'http'

module BaiduGeocoder
  class Geocoder
    ApiHost = "http://api.map.baidu.com"
    ApiAction = "/geocoder/v2/"
    ApiUrl = ApiHost + ApiAction
    DefaultAK = "LDw1AMLeanI9hEMjKG4DCzczYVaxAYFC"
    DefaultLocation = {:lng => 116.421885, :lat => 39.938574, :status => false}.freeze
    DefaultAddress = {:province => "北京市", :city => "市辖区", :district => "东城区", :formatted_address => "北京市市辖区东城区", :status => false}.freeze

    class << self

      ## get location by address
      def get_location_by_addr(addr,city = nil, ak = DefaultAK, http = HTTP)
        names = {'宁夏' => '宁夏回族自治区', '新疆'=> '新疆维吾尔自治区', '西藏'=>  '西藏自治区', 
          '广西'=> '广西壮族自治区', '内蒙'=> '内蒙古自治区'}
        names.each do |k,v|
          addr.gsub!(/#{k}/, v)
        end
        params = {:address => addr, :city => city}.merge({:output => "json", :ak => ak})
        loc = {}.merge(DefaultLocation)
        begin
          res = http.get(ApiUrl, :params => params).flush
          if res.code == 200
            json = JSON.parse(res.body)
            if "0".eql?(json["status"].to_s) && json["result"] && !json["result"].empty? \
              && json["result"]["location"] && !json["result"]["location"] .empty?
              loc[:lng] = json["result"]["location"]["lng"]
              loc[:lat] = json["result"]["location"]["lat"]
              loc[:status] = true
            end
          end
        rescue Exception => e
          puts "Exception=> #{e}"
        end
        loc
      end

      ## get address by location(latitude, longtitude)
      def get_address_by_loc(lat, lng, ak = DefaultAK, http = HTTP)
        params = {:location => "#{lat},#{lng}"}.merge({:output => "json", :ak => ak})
        address = {}.merge(DefaultAddress)
        begin
          res = http.get(ApiUrl, :params => params).flush

          if res.code == 200
            json = JSON.parse(res.body)
            if "0".eql?(json["status"].to_s) && json["result"] && !json["result"].empty? \
              && json["result"]["addressComponent"] && !json["result"]["addressComponent"].empty? \
              && json["result"]["formatted_address"] && !json["result"]["formatted_address"].empty?
              address[:formatted_address] = json["result"]["formatted_address"]
              address[:province] = json["result"]["addressComponent"]["province"]
              address[:city] = json["result"]["addressComponent"]["city"]
              address[:district] = json["result"]["addressComponent"]["district"]
              address[:status] = true
            end
          end
        rescue Exception => e
          puts "Exception => #{e}"
        end

        address
      end

      def get_address_by_name name, ak = DefaultAK
        loc = get_location_by_addr(name, ak)
        address = get_address_by_loc(loc[:lat], loc[:lng], ak)
        address[:status] = loc[:status] && address[:status]
        address
      end
    end
  end

end
