require 'open-uri'
require 'json'

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

    @url_street = "http://maps.googleapis.com/maps/api/geocode/json?address=#{url_safe_street_address}"

    @parsed_data = JSON.parse(open(@url_street).read)

    @lat = @parsed_data["results"][0]["geometry"]["location"]["lat"]

    @lng = @parsed_data["results"][0]["geometry"]["location"]["lng"]


    @url_weather = "https://api.forecast.io/forecast/5e4c5243c1dcc5ccb1bdbc595ffb61f8/#{@lat},#{@lng}"

    @parsed_data = JSON.parse(open(@url_weather).read)

    @current_temperature = @parsed_data["currently"]["temperature"]

    @current_summary = @parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = @parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = @parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = @parsed_data["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
