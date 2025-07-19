package com.example.weather_app

import android.os.Handler
import android.os.Looper
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.weather_app/channel"
    private val mainHandler = Handler(Looper.getMainLooper())

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            val apiKey = BuildConfig.WEATHERAPI_KEY

            when (call.method) {
                "getWeatherFromRust" -> {
                    val city = call.argument<String>("city") ?: "London"
                    CoroutineScope(Dispatchers.IO).launch {
                        val output = WeatherBridge.getWeatherFromRust(city, apiKey)
                        withContext(Dispatchers.Main) {
                            result.success(output)
                        }
                    }
                }

                "searchCitiesFromRust" -> {
                    val query = call.argument<String>("query") ?: ""
                    CoroutineScope(Dispatchers.IO).launch {
                        val output = WeatherBridge.searchCitiesFromRust(query, apiKey)
                        withContext(Dispatchers.Main) {
                            result.success(output)
                        }
                    }
                }

                else -> result.notImplemented()
            }
        }
    }
}