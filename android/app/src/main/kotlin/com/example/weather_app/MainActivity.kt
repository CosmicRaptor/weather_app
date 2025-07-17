package com.example.weather_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.example.weather_app.WeatherBridge

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.weather_app/channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "getWeatherFromRust") {
                    val apiKey = BuildConfig.WEATHERAPI_KEY
                    val city = call.argument<String>("city") ?: "London"
                    val output = WeatherBridge.getWeatherFromRust(city, apiKey)
                    result.success(output)
                } else {
                    result.notImplemented()
                }
            }
    }
}
