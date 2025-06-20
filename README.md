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

## 🛠 Tech Stack

- Flutter & Dart
- OpenWeatherMap API
- HTTP package
- SharedPreferences

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


```

🔧 TODOs / Future Enhancements
 Add Google Maps support as an alternative option.

 Allow live GPS location of the user and show local weather.

 Add forecast view (e.g., 5-day weather forecast).

 Store full weather response in local storage for offline access.

 Add unit toggle (°C to °F).

 Improve UI with animations and custom themes.

 Add platform-specific enhancements for iOS and Web.

 Add error logging or bug reporting service (e.g., Firebase Crashlytics).
