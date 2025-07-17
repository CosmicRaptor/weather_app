package com.example.weather_app

object WeatherBridge {
    init {
        System.loadLibrary("rust_weather")
    }

    external fun getWeatherFromRust(city: String, apiKey: String): String
}