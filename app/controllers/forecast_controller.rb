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

    url = "https://api.forecast.io/forecast/6f6dc44188ee697d1db06681e0e142a9/#{@lat},#{@lng}"
    parsed_data = JSON.parse(open(url).read)

    @currenttemp = parsed_data["currently"]["temperature"]

    @currentsummary = parsed_data["currently"]["summary"]

    @nextsixtyminutes = parsed_data["minutely"]["summary"]

    @nextseveralhours = parsed_data["hourly"]["summary"]

    @nextseveraldays = parsed_data["daily"]["summary"]

    render("coords_to_weather.html.erb")
  end
end