class HelperController < ApplicationController
  def weather_data(game)
    forecast_key = ENV["FORECAST_KEY"]
    latitude = game.latitude
    longitude = game.longitude
    time = "#{game.game_day.strftime('%Y-%m-%d')}T#{game.game_time.strftime('%H:%M:%S')}"
    forecast = HTTParty.get("https://api.forecast.io/forecast/#{forecast_key}/#{latitude},#{longitude},#{time}")
    @temp = forecast["currently"]["temperature"].round
    @weather_description = forecast["currently"]["icon"]
    if forecast["currently"]["precipProbability"]
      @precipitation = ", #{(forecast["currently"]["precipProbability"] * 100).round}% chance of rain"
    end
  end
end
