# 🌤️ Flutter Weather App (with Rust via JNI)

A beautiful, animated Flutter weather app powered by [WeatherAPI](https://www.weatherapi.com/), built with:

- 🦀 **Rust** for native weather fetching via `reqwest`
- 📱 **Flutter** (MVVM + Riverpod) for cross-platform UI
- 🔌 JNI to bridge Rust <-> Android
- 🎞️ Weather-based background animations (GIF/WebP)
- ❄️ Glassmorphic UI with frosted containers
- 📊 Widgets for hourly and daily forecasts, UV, pressure, sunrise/sunset & more

---

## 📸 Preview



https://github.com/user-attachments/assets/5f20175e-7132-4ef4-a0af-d1e6d6f6561d

<a target="_blank" href="https://icons8.com/icon/Kp3P6lR6ggpq/weather-app">Weather App</a> icon by <a target="_blank" href="https://icons8.com">Icons8</a>



---

## 🚀 Features

- 🔄 Real-time weather data (current + 5-day forecast)
- ❄️ Beautiful glassmorphism UI using `BackdropFilter`
- 🌁 Animated weather backgrounds using optimized GIFs

---
## 🛠️ Setup Instructions

### ✅ Prerequisites
- Flutter SDK
- Rust
- Android Studio or VSCode with Android SDK
- Working Android NDK toolchain

### 🔐 WeatherAPI Key
Create a local.properties file in your project's android directory:

```
weatherapi_key=YOUR_API_KEY_HERE
```

### Build runner
```
dart run build_runner build
```


