# 🌦 Weather App – Detailed Explanation

This document explains the complete working of the Weather App.
Main focus areas:

* How the API works
* How data is fetched
* How JSON is handled
* How widgets are structured
* How UI updates dynamically

The explanation is written in simple English for better understanding.

---

# 📌 Project Purpose

This app allows the user to:

1. Enter a city name
2. Fetch weather data from OpenWeatherMap API
3. Display:

   * City name
   * Temperature
   * Weather condition
   * Humidity
   * Wind speed
   * Feels like temperature
   * Visibility
   * Static AQI status

---

# 🧱 App Structure Overview

```
StatefulWidget
   ↓
State Class
   ↓
TextEditingController
   ↓
getWeather() function (API call)
   ↓
jsonDecode()
   ↓
setState()
   ↓
UI updates automatically
```

---

# 🧠 Why StatefulWidget?

This app uses:

```dart
class WeatherApp extends StatefulWidget
```

We use StatefulWidget because:

* Weather data changes
* UI must update dynamically
* setState() is required

If it was StatelessWidget, UI could not update after API call.

---

# 📦 Packages Used

```dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
```

## 1️⃣ dart:convert

Used for:

```dart
jsonDecode(response.body);
```

It converts JSON string into Dart Map.

---

## 2️⃣ material.dart

Provides all UI components:

* Scaffold
* AppBar
* Container
* Text
* Row
* Column
* Colors
* TextFormField
* ElevatedButton

---

## 3️⃣ http package

Used for:

```dart
http.get(url);
```

It sends request to the API server.

---

# 🔑 API SECTION (Main Focus)

This is the most important part.

---

# 🔹 Step 1: Preparing API URL

```dart
Uri url = Uri.parse(
  "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric"
);
```

## What this does:

* `q=$city` → user input city
* `appid=$apiKey` → your unique API key
* `units=metric` → temperature in Celsius

This creates the final API URL.

---

# 🔹 Step 2: Sending Request

```dart
final response = await http.get(url);
```

Explanation:

* `await` waits for API response
* `http.get()` sends GET request
* Response comes from server

---

# 🔹 Step 3: Checking Response

```dart
if (response.statusCode == 200)
```

Status code 200 means:

* Request successful
* Data received correctly

If not 200 → error occurred.

---

# 🔹 Step 4: Converting JSON to Dart

```dart
final data = jsonDecode(response.body);
```

API returns JSON like this:

```json
{
  "name": "Delhi",
  "main": {
    "temp": 28,
    "humidity": 25,
    "feels_like": 30
  },
  "weather": [
    { "main": "Clouds" }
  ],
  "wind": {
    "speed": 3.5
  },
  "visibility": 10000
}
```

After jsonDecode:

* It becomes a Dart Map
* We can access values using keys

---

# 🔹 Step 5: Extracting Data

```dart
cityName = data['name'];
temperature = data['main']['temp'].toString();
condition = data['weather'][0]['main'];
humidity = data['main']['humidity'].toString();
windSpeed = data['wind']['speed'].toString();
feelsLike = data['main']['feels_like'].toString();
visibility = (data['visibility'] / 1000).toString();
```

Explanation:

* `data['name']` → city name
* `data['main']` → contains temperature info
* `data['weather'][0]` → weather condition
* `data['wind']` → wind data
* visibility is divided by 1000 to convert meters to KM

---

# 🔹 Step 6: Updating UI

```dart
setState(() {
  cityName = ...
});
```

Important:

* setState tells Flutter:
  "Data changed. Rebuild UI."

Without setState → UI will not update.

---

# 🔄 Complete API Flow

```
User enters city
   ↓
Press button
   ↓
getWeather() called
   ↓
Create URL
   ↓
Send request using http.get
   ↓
Receive response
   ↓
Convert JSON using jsonDecode
   ↓
Store values
   ↓
Call setState
   ↓
UI updates automatically
```

---

# 🧩 Widgets Explanation

---

# 🔹 Scaffold

Main screen structure:

```dart
Scaffold(
  appBar: ...
  body: ...
)
```

Provides:

* AppBar
* Body
* Background color

---

# 🔹 AppBar

```dart
AppBar(
  elevation: 0,
  centerTitle: true,
)
```

Properties used:

* elevation → removes shadow
* centerTitle → centers title
* backgroundColor → dark theme

---

# 🔹 Container

Used for:

* Background
* Cards
* Box styling
* Gradient
* Border radius

Example:

```dart
Container(
  decoration: BoxDecoration(
    color: Color(0xFF1B263B),
    borderRadius: BorderRadius.circular(18),
  ),
)
```

---

# 🔹 LinearGradient

```dart
LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
)
```

Creates smooth background color transition.

---

# 🔹 Column

Arranges widgets vertically.

---

# 🔹 Row

Arranges widgets horizontally.

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
)
```

Pushes text to left and right side.

---

# 🔹 TextFormField

Used for input.

Important parts:

* controller → connects input to variable
* decoration → styling
* filled + fillColor → background color

---

# 🔹 ElevatedButton

```dart
ElevatedButton(
  onPressed: getWeather,
)
```

When pressed:

* Calls getWeather()
* Triggers API call

---

# 🔹 SingleChildScrollView

Prevents overflow if content is large.

Allows vertical scrolling.

---

# 🔹 Reusable Widget (_infoCard)

This method avoids code repetition.

```dart
Widget _infoCard(...)
```

Why used?

* Same card design repeated
* Keeps code clean
* Easy to maintain

---

# 🎨 Colors Used

| Color Code        | Purpose         |
| ----------------- | --------------- |
| 0xFF0A0F1C        | Main background |
| 0xFF1B263B        | Card background |
| 0xFF243447        | Info card       |
| 0xFF003566        | Gradient start  |
| 0xFF001D3D        | Gradient end    |
| Colors.blueAccent | Button          |
| Colors.green      | AQI             |

---

# ⚙️ State Management

Simple state management using:

```dart
setState()
```

Whenever data changes:

* Flutter rebuilds widget tree
* UI updates automatically

---

# 📚 Key Concepts Learned

* StatefulWidget
* setState()
* async / await
* http.get()
* jsonDecode()
* API URL structure
* Extracting nested JSON
* Using controllers
* Conditional UI display
* Reusable widgets

---

# 📈 What Makes This App Dynamic?

These values change based on city:

* cityName
* temperature
* condition
* humidity
* windSpeed
* feelsLike
* visibility

All these are fetched live from API.

---

# 🏁 Final Summary

This Weather App demonstrates:

* Real API integration
* JSON parsing
* Dynamic UI updates
* Clean UI structure
* Beginner-friendly architecture
* Proper separation of logic and UI

It is a strong foundation for building more advanced Flutter apps.
