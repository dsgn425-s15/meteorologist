require 'open-uri'

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

    geocoding_url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{url_safe_street_address}"

    geocoding_raw_results = open(geocoding_url).read

    geocoding_parsed_results = JSON.parse(geocoding_raw_results)

    location_hash = geocoding_parsed_results["results"][0]["geometry"]["location"]

    @latitude = location_hash["lat"]

    @longitude = location_hash["lng"]

    forecast_url = "https://api.forecast.io/forecast/6a153e09d1f030291cd400724e2d2c5f/#{@latitude},#{@longitude}"

    forecast_raw_results = open(forecast_url).read

    forecast_parsed_results = JSON.parse(forecast_raw_results)

    @current_temperature = forecast_parsed_results["currently"]["temperature"]

    @current_summary = forecast_parsed_results["currently"]["summary"]

    @summary_of_next_sixty_minutes = forecast_parsed_results["minutely"]["summary"]

    @summary_of_next_several_hours = forecast_parsed_results["hourly"]["summary"]

    @summary_of_next_several_days = forecast_parsed_results["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
