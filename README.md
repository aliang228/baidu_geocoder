# BaiduGeocoder[![Gem Version](https://badge.fury.io/rb/baidu_geocoder.svg)](http://badge.fury.io/rb/baidu_geocoder)

使用百度地图API进行地址定位坐标、坐标定位地址、名称定位地址。

## 安装

    $ gem install baidu_geocoder

## 使用

### 调用

```ruby
require 'baidu_geocoder'
include 'BaiduGeocoder'

## get_location_by_addr
loc = Geocoder.get_location_by_addr(addr)

## get_address_by_name
addr = Geocoder.get_address_by_name(name)

## get_address_by_loc
addr = Geocoder.get_address_by_loc(lat, lng)

```

- tips: BaiduMapApi需要申请 MapAk. 为了避免因为ak限制问题，您也可以传入自己的ak([申请地址](http://lbsyun.baidu.com/apiconsole/key))

```ruby
loc = Geocoder.get_location_by_addr(addr, your_ak)
```

### 命令行

```
➜  baidu_geocoder git:(master) ✗ baidu_geocoder
  Usage:
      baidu_geocoder -a addr    : 返回坐标
      baidu_geocoder -n name    : 返回地址
      baidu_geocoder -l lat lng : 返回地址
➜  baidu_geocoder git:(master) ✗ baidu_geocoder -n 北京市政府
获取地址成功:
{:province=>"北京市", :city=>"北京市", :district=>"西城区", :formatted_address=>"北京市西城区文津街"}

➜  baidu_geocoder git:(master) ✗ baidu_geocoder -a 北京市西城区文津街
获取定位成功:
{:lng=>116.39321980074757, :lat=>39.92881485241565}

➜  baidu_geocoder git:(master) ✗ baidu_geocoder -l 39.92881485241565 116.39321980074757
获取地址成功:
{:province=>"北京市", :city=>"北京市", :district=>"西城区", :formatted_address=>"北京市西城区文津街3号"}

```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

