require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    require'open-uri'
    require 'JSON'
    url_safe_street_address = URI.encode(@street_address)

    #call and interpret the google api to get lat an lng
    url = "http://maps.googleapis.com/maps/api/geocode/json?address="+ url_safe_street_address
    parsed_data_maps = JSON.parse(open(url).read)
    @latitude = parsed_data_maps["results"][0]["geometry"]["location"]["lat"]
    @longitude = parsed_data_maps["results"][0]["geometry"]["location"]["lng"]

    @lat = @latitude.to_s
    @lng = @longitude.to_s

    #call and interpret weather api to get weather data
    url = "https://api.forecast.io/forecast/b7a322855f98349c4748eaabb199267d/" + @lat + "," + @lng
    parsed_data = JSON.parse(open(url).read)

    @current_temperature = parsed_data["currently"]["temperature"]

    @current_summary = parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
