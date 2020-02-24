require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }  

#news API
url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=72062d412df44b118b2b3128033cf057"
news = HTTParty.get(url).parsed_response.to_hash
@title0= news["articles"][0]["title"]
@url0= news["articles"][0]["url"]
@description0 = url1= news["articles"][0]["description"] 

puts title0
puts url0
puts description0