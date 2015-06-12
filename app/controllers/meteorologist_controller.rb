require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    mapsapi_url = "http://maps.googleapis.com/maps/api/geocode/json?address="
    forecastapi_url = "https://api.forecast.io/forecast/"
    api_key = "56ca9c9c719f5c97d1b05fba6d5e83e6"

    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================

    raw_geo_data = open(mapsapi_url+url_safe_street_address).read
    parsed_geo_data = JSON.parse(raw_geo_data)
    latitude = parsed_geo_data["results"][0]["geometry"]["location"]["lat"].to_s
    longitude = parsed_geo_data["results"][0]["geometry"]["location"]["lng"].to_s

    raw_weather_data = open(forecastapi_url + api_key +"/" + latitude + "," + longitude).read
    parsed_weather_data=JSON.parse(raw_weather_data)

    @current_temperature = parsed_weather_data["currently"]["temperature"]

    @current_summary = parsed_weather_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_weather_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_weather_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_weather_data["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
