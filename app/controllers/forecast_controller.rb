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

    url = "https://api.forecast.io/forecast/6a153e09d1f030291cd400724e2d2c5f/#{@lat},#{@lng}"

    raw_results = open(url).read

    parsed_results = JSON.parse(raw_results)

    @current_temperature = parsed_results["currently"]["temperature"]

    @current_summary = parsed_results["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_results["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_results["hourly"]["summary"]

    @summary_of_next_several_days = parsed_results["daily"]["summary"]

    render("coords_to_weather.html.erb")
  end
end
