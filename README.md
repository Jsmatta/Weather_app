# 🌤️ Weather App

A beautiful, modern iOS weather application built with SwiftUI that provides real-time weather information based on your current location.

![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)
![iOS](https://img.shields.io/badge/iOS-14.0+-blue.svg)
![Xcode](https://img.shields.io/badge/Xcode-12.0+-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

## ✨ Features

- **📍 Location-Based Weather**: Automatically detects your current coordinates and fetches weather data
- **🌡️ Comprehensive Weather Data**: 
  - Current temperature and "feels like" temperature
  - Minimum and maximum daily temperatures
  - Humidity levels
  - Wind speed and direction
  - Weather conditions (sunny, rainy, cloudy, etc.)
- **🎨 Beautiful UI**: Modern Tokyo Night theme with smooth gradients and elegant design
- **🌈 Dynamic Icons**: Weather-specific SF Symbols with contextual colors
- **📱 Native iOS Experience**: Built entirely with SwiftUI for optimal performance

### Prerequisites

- Xcode 12.0 or later
- iOS 14.0 or later
- OpenWeatherMap API key

## 🛠️ Technology Stack

- **SwiftUI**: Modern declarative UI framework
- **Core Location**: GPS coordinate detection
- **URLSession**: HTTP networking for API calls
- **Combine**: Reactive programming for data flow
- **OpenWeatherMap API**: Weather data provider

## 🌐 API Integration

The app integrates with the OpenWeatherMap Current Weather Data API:

- **Endpoint**: `https://api.openweathermap.org/data/2.5/weather`
- **Parameters**: 
  - `lat`: Latitude coordinate
  - `lon`: Longitude coordinate
  - `appid`: Your API key
  - `units`: Metric system for temperature

### Sample API Response
```json
{
  "weather": [{"main": "Clear", "description": "clear sky"}],
  "main": {
    "temp": 22.5,
    "feels_like": 21.8,
    "temp_min": 18.2,
    "temp_max": 26.1,
    "humidity": 45
  },
  "wind": {"speed": 3.2, "deg": 180},
  "name": "Your City"
}
```

## 🎨 Design System

### Tokyo Night Theme
The app features a custom Tokyo Night color scheme:

- **Background**: Deep navy (`#16161e`)
- **Surface**: Dark blue-gray (`#24283b`) 
- **Primary**: Tokyo blue (`#7aa2f7`)
- **Accent**: Purple (`#ab4ded`)
- **Text**: Light blue-white (`#c0caf5`)

## 📱 Permissions

The app requires the following permissions:
- **Location Services**: To determine your current coordinates for weather data

## 🙏 Acknowledgments

- [OpenWeatherMap](https://openweathermap.org/) for providing the weather API
- [Tokyo Night](https://github.com/enkia/tokyo-night-vscode-theme) for the color scheme inspiration
