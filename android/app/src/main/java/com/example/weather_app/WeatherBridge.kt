package com.example.weather_app

object WeatherBridge {
    init {
        System.loadLibrary("rust_weather") // Use your actual Rust .so lib name
    }

    external fun getWeatherFromRust(city: String, apiKey: String): String

    external fun searchCitiesFromRust(query: String, apiKey: String): String
}
