# 🌦 Weather App – Complete README

## 📌 Project Overview

This is a simple Flutter Weather App that:

* Takes a city name as input
* Calls OpenWeatherMap API
* Displays:

  * City Name
  * Temperature
  * Weather Condition
  * Humidity
  * Wind Speed
  * Feels Like Temperature
  * Visibility
  * Static AQI Status

The app uses basic Flutter widgets and simple API integration using the `http` package.

This project is beginner-friendly and does not use advanced state management.

---

# 🧱 Project Structure

The app contains:

* `StatefulWidget`
* API Call using `http.get`
* JSON parsing using `jsonDecode`
* UI built using Containers, Rows, Columns
* Reusable custom method `_infoCard()`

---

# 📦 Packages Used

```dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
```

### 1️⃣ dart:convert

Used for:

* `jsonDecode()` → Converts API JSON response into Dart Map

### 2️⃣ material.dart

Provides:

* Scaffold
* AppBar
* Container
* Text
* Row / Column
* Colors
* TextFormField
* ElevatedButton
* etc.

### 3️⃣ http package

Used to:

* Make API requests using `http.get()`

---

# 🧠 App Architecture

The app uses:

```
StatefulWidget
   ↓
State class
   ↓
Variables (Weather Data)
   ↓
getWeather() method
   ↓
API Call
   ↓
setState()
   ↓
UI updates
```

---

# 🧩 Widgets Used & Explanation

## 🔹 Scaffold

Main layout structure.
Contains:

* AppBar
* Body

---

## 🔹 AppBar

```dart
AppBar(
  elevation: 0,
  centerTitle: true,
  backgroundColor: Color(0xFF0A0F1C),
)
```

### Properties Used:

* `elevation: 0` → Removes shadow
* `centerTitle: true` → Centers title
* `backgroundColor` → Dark background
* `leading` → Icon on left side

---

## 🔹 Container

Used everywhere for:

* Background color
* Gradient
* Border radius
* Padding
* Shadow

Example:

```dart
Container(
  decoration: BoxDecoration(
    color: Color(0xFF1B263B),
    borderRadius: BorderRadius.circular(18),
  ),
)
```

### BoxDecoration Properties:

* `color` → Background color
* `gradient` → Linear gradient
* `borderRadius` → Rounded corners
* `boxShadow` → Shadow effect

---

## 🔹 LinearGradient

Used for background effect:

```dart
LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF0A0F1C),
    Color(0xFF111B2E),
    Color(0xFF162338),
  ],
)
```

### What it does:

Creates smooth color transition from top to bottom.

---

## 🔹 Column

Used to arrange widgets vertically.

```dart
Column(
  children: [],
)
```

---

## 🔹 Row

Used to arrange widgets horizontally.

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
)
```

### Important Property:

* `spaceBetween` → Pushes widgets to both ends

---

## 🔹 TextFormField

Used to take city input.

Important properties:

* `controller`
* `decoration`
* `filled`
* `fillColor`
* `border`

---

## 🔹 ElevatedButton

Used to trigger API call.

```dart
ElevatedButton(
  onPressed: getWeather,
)
```

---

# 🌍 API Integration Explained

## API Used:

OpenWeatherMap

### API URL Template:

```
https://api.openweathermap.org/data/2.5/weather?q=CITY&appid=APIKEY&units=metric
```

### Parameters:

| Parameter    | Meaning                |
| ------------ | ---------------------- |
| q            | City Name              |
| appid        | API Key                |
| units=metric | Temperature in Celsius |

---

# 🔄 getWeather() Method Explained

```dart
Future<void> getWeather() async
```

### Step-by-Step Workflow:

1. Set loading true
2. Get city from TextField
3. Create API URL using Uri.parse()
4. Call API using `http.get()`
5. Check response status
6. Decode JSON
7. Store values in variables
8. Call `setState()` to update UI
9. Set loading false

---

## 🧾 JSON Parsing

Example API response structure:

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

### Accessing Data:

```dart
data['name']
data['main']['temp']
data['weather'][0]['main']
data['wind']['speed']
```

---

# 🎨 Colors Used

| Color Code        | Purpose          |
| ----------------- | ---------------- |
| 0xFF0A0F1C        | Background base  |
| 0xFF1B263B        | Card background  |
| 0xFF003566        | Primary gradient |
| 0xFF001D3D        | Dark blue        |
| Colors.blueAccent | Button           |
| Colors.green      | AQI Good         |

---

# 🧱 Reusable Method: _infoCard()

This method creates reusable UI for Box 2 and Box 3.

```dart
Widget _infoCard(...)
```

### Why Used?

* Avoid repeating same UI code
* Keeps code clean
* Makes UI scalable

---

# 🔄 State Management

The app uses simple `setState()`.

When:

```dart
setState(() {
  cityName = ...
});
```

Flutter rebuilds the widget and updates UI.

---

# 📱 UI Workflow

```
User enters city
     ↓
User presses button
     ↓
getWeather() called
     ↓
API request sent
     ↓
Data received
     ↓
Variables updated
     ↓
UI rebuilds automatically
```

---

# ⚙️ Important Concepts Used

| Concept                                 | Purpose                       |
| --------------------------------------- | ----------------------------- |
| StatefulWidget                          | UI changes dynamically        |
| setState                                | Refresh UI                    |
| async / await                           | Handle API calls              |
| http.get                                | Fetch data                    |
| jsonDecode                              | Convert JSON                  |
| TextEditingController                   | Get input value               |
| Conditional UI (if cityName.isNotEmpty) | Show data only when available |

---

# 🚀 Beginner Learning Points

From this project you learned:

* API Integration
* JSON parsing
* HTTP requests
* State management
* UI layout design
* Gradients and styling
* Reusable widgets
* Clean structure

---

# 📌 Future Improvements

You can later add:

* Real AQI API
* Weather icons
* Error messages
* Background change by weather
* Location permission
* Loading animation
* Try/Catch error dialog

---

# ✅ Conclusion

This app is:

* Simple
* Beginner-friendly
* Clean UI
* Real API integrated
* Proper structured

It is a solid foundation for learning Flutter + API integration.

---

End of README.
