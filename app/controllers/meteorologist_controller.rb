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

    url1 = "https://maps.googleapis.com/maps/api/geocode/json?address="+url_safe_street_address+"&sensor=false"

    parsed_data = JSON.parse(open(url1).read)

    @lat = parsed_data["results"][0]["geometry"]["location"]["lat"].to_s

    @lng = parsed_data["results"][0]["geometry"]["location"]["lng"].to_s

    url = "https://api.forecast.io/forecast/f8cba70e2338da9c1a86ac2bb9846a77/"+@lat+","+@lng

    parsed_data = JSON.parse(open(url).read)

    #@latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

    #@longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]


    @current_temperature = parsed_data["currently"]["temperature"]

    @current_summary = parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
