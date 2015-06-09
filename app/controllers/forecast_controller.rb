require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    url = "https://api.forecast.io/forecast/f8cba70e2338da9c1a86ac2bb9846a77/"+@lat+","+@lng

    parsed_data = JSON.parse(open(url).read)

    #@latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

    #@longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]


    @current_temperature = parsed_data["currently"]["temperature"]

    @current_summary = parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data["daily"]["summary"]

    render("coords_to_weather.html.erb")
  end
end
