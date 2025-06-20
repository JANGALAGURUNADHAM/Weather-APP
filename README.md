# 🌦️ Flutter Weather App

This is a weather app built in Flutter as part of the internship assignment for Oro.  
It fetches real-time weather data using the OpenWeatherMap API.

---

## ✅ Features Implemented

- 🔍 City search input
- 🌡️ Displays temperature in Celsius
- ☁️ Shows weather condition (e.g., Clear, Rainy)
- 🖼️ Weather icon based on condition
- ⏳ Loading indicator while fetching data
- ❌ Error handling if city not found
- ✅ Success state with weather info
- 💾 Recent city search saved (top 5, using SharedPreferences)
- 🔄 Pull-to-refresh support
- 📱 Responsive layout using Flutter widgets

---

## 🧰 Tech Stack

- 🧪 Language: Dart
- 📱 Framework: Flutter
- 🌐 API: [OpenWeatherMap](https://openweathermap.org/api)
- 📦 Packages:
  - `http`
  - `shared_preferences`
  - `flutter_map`
  - `latlong2`
  - `flutter_dotenv`

---

## 🖼️ Screenshots

### ✅ Weather Displayed for City

![WhatsApp Image 2025-06-21 at 00 26 04_fd181c99](https://github.com/user-attachments/assets/843dca51-5f70-4387-8837-a6df4557da60)

![WhatsApp Image 2025-06-21 at 00 26 05_7f7b2350](https://github.com/user-attachments/assets/795e5a4e-7ef4-431d-aa9f-912fa9cc840e)

### ✅ City List

![WhatsApp Image 2025-06-21 at 00 26 05_56b227af](https://github.com/user-attachments/assets/8558dc7d-5415-46cd-9964-e5a7e08f10a4)


### ✅ Recent Cities List

![WhatsApp Image 2025-06-21 at 00 26 28_578a54ce](https://github.com/user-attachments/assets/7e4b8c23-9a93-4b9f-95e4-cc19163479c9)

---

## 🚀 How to Run

1. Clone this repo or download ZIP
2. Run:
   ```bash
   flutter pub get

---

📝 Assumptions & TODOs


🔐 Assumes API key is provided via .env file (not committed)

🗂️ Uses OpenStreetMap via flutter_map for map rendering

📱 Mobile-first UI but responsive for Windows/Web as well

✅ Done: Map marker for searched city

📋 TODOs / Enhancements:

 GPS location & local weather

 Forecast view (5-day weather)

 °C / °F toggle

 Offline caching for weather

 Firebase Crashlytics for errors

 Improve design with animations & themes

---
 Add platform-specific enhancements for iOS and Web.

 Add error logging or bug reporting service (e.g., Firebase Crashlytics).
