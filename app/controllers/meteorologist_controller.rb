require 'open-uri'
require 'JSON'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================
    google_url ="http://maps.googleapis.com/maps/api/geocode/json?address="
    parsed_data = JSON.parse(open(google_url+url_safe_street_address.to_s).read)

     lng = parsed_data["results"][0]["geometry"]["location"]["lng"]
    lat = parsed_data["results"][0]["geometry"]["location"]["lat"]



    forecast_url = "https://api.forecast.io/forecast/"
    api_key = "f5d6b3d45361818b6b83099b5d558d91/"
    parsed_data2 = JSON.parse(open(forecast_url+api_key+lat.to_s+","+lng.to_s).read)

    @current_temperature = parsed_data2["currently"]["temperature"]

    @current_summary = parsed_data2["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data2["hourly"]["data"][0]["summary"]

    @summary_of_next_several_hours = parsed_data2["hourly"]["summary"]
    @summary_of_next_several_days = parsed_data2["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
