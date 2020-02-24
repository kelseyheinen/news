require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
ForecastIO.api_key = "7fc61e89b4b650fd369947c35d74fa91"

#news API
url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=72062d412df44b118b2b3128033cf057"
news = HTTParty.get(url).parsed_response.to_hash

# show a view that asks for the location
get "/" do
  view "ask"
end

get "/news" do
#get results from 'ask'
    results = Geocoder.search(params["q"])
    lat_long = results.first.coordinates # => [lat, long]
    "#{lat_long[0]} #{lat_long[1]}"
    location = results.first.city
   
#define location, lat, and long
 @lat = "#{lat_long[0]}"
 @long = "#{lat_long[1]}"
 @location = location

#pull forecast for searched location
forecast = ForecastIO.forecast("#{@lat}", "#{@long}").to_hash
@current_temperature = forecast["currently"]["temperature"]
@current_conditions = forecast["currently"]["summary"].downcase

@today_high = forecast["daily"]["data"][0]["temperatureHigh"]
@today_low = forecast["daily"]["data"][0]["temperatureLow"]
@today_summary = forecast["daily"]["data"][0]["summary"]

@tomorrow_high = forecast["daily"]["data"][1]["temperatureHigh"]
@tomorrow_low = forecast["daily"]["data"][1]["temperatureLow"]
@tomorrow_summary = forecast["daily"]["data"][1]["summary"]

@twoday_high = forecast["daily"]["data"][2]["temperatureHigh"]
@twoday_low = forecast["daily"]["data"][2]["temperatureLow"]
@twoday_summary = forecast["daily"]["data"][2]["summary"]

#pull news data for searched location
@title0= news["articles"][0]["title"]
@url0= news["articles"][0]["url"]
@description0 = url1= news["articles"][0]["description"] 

@title1= news["articles"][1]["title"]
@url1= news["articles"][1]["url"]
@description1 = url1= news["articles"][1]["description"] 

@title2= news["articles"][2]["title"]
@url2= news["articles"][2]["url"]
@description2 = url1= news["articles"][2]["description"] 

@title3= news["articles"][3]["title"]
@url3= news["articles"][3]["url"]
@description3 = url1= news["articles"][3]["description"] 

@title4= news["articles"][4]["title"]
@url4= news["articles"][4]["url"]
@description4 = url1= news["articles"][4]["description"] 

 view "news"
end
