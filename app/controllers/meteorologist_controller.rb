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

  # Location mapping
  google_url = "http://maps.googleapis.com/maps/api/geocode/json?address="
  parsed_mapdata = JSON.parse(open(google_url+url_safe_street_address).read)
  @lat = parsed_mapdata["results"][0]["geometry"]["location"]["lat"]
  @lng = parsed_mapdata["results"][0]["geometry"]["location"]["lng"]

  # Weather mapping
  location_url = @lat.to_s+','+@lng.to_s
  darksky_url = "https://api.forecast.io/forecast/12ab4de221b5a6cd202b2ec39cfa700f/"

  parsed_data = JSON.parse(open(darksky_url+location_url).read)

  @current_temperature = parsed_data["currently"]["temperature"]

  @current_summary = parsed_data["currently"]["summary"]

  @summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]

  @summary_of_next_several_hours =  parsed_data["hourly"]["summary"]

  @summary_of_next_several_days = parsed_data["daily"]["summary"]

  render("street_to_weather.html.erb")
end
end
