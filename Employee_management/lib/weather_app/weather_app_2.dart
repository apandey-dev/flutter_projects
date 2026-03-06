import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final TextEditingController _cityController = TextEditingController();

  String cityName = "";
  String temperature = "";
  String condition = "";
  String cloud = "";
  String humidity = "";
  String windSpeed = "";
  String feelsLike = "";
  String visibility = "";

  String aqiStatus = "Good";
  Color aqiColor = Colors.green;

  bool isLoading = false;

  Future<void> getWeather() async {
    setState(() {
      isLoading = true;
    });

    String city = _cityController.text.trim();
    String apiKey = "b1cedb626d1bcd73378e43238f3bd007";

    Uri url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric",
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          cityName = data['name'];
          temperature = data['main']['temp'].toString();
          condition = data['weather'][0]['main'.toString()];
          cloud = data['clouds']['all'].toString();
          humidity = data['main']['humidity'].toString();
          windSpeed = data['wind']['speed'].toString();
          feelsLike = data['main']['feels_like'].toString();
          visibility = (data['visibility'] / 1000).toString();
        });
      }
    } catch (e) {
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0F1C),

      // ===================== IMPROVED APP BAR =====================
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 199, 205, 223),
        title: const Text(
          "Weather App",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        leading: const Icon(Icons.wb_cloudy_rounded, color: Colors.blue),
      ),

      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0A0F1C), Color(0xFF111B2E), Color(0xFF162338)],
          ),
        ),

        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Heading Of City name
              const Text(
                "Enter City Name",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),

              const SizedBox(height: 20),

              // ================= INPUT For City From User =================
              TextFormField(
                controller: _cityController,
                style: const TextStyle(color: Colors.white),

                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_city),
                  prefixIconColor: Colors.white70,
                  hintText: "Search City...",
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: const Color(0xFF1B263B),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Button Get Weather
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: getWeather,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Get Weather",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                ),
              ),

              const SizedBox(height: 30),

              // ================= WEATHER SECTION =================
              if (cityName.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B263B),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // ---------- BOX 1 ----------
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF003566), Color(0xFF001D3D)],
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Text(
                              cityName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "$temperature°C",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 46,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              condition,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 18),

                      // ---------- BOX 2 ----------
                      _infoCard(
                        title1: "AQI",
                        value1: aqiStatus,
                        extraTitle: "Clouds",
                        extraValue: cloud,
                        valueColor: aqiColor,
                        title2: "Humidity",
                        value2: "$humidity %",
                      ),

                      const SizedBox(height: 14),

                      // ---------- BOX 3 ----------
                      _infoCard(
                        title1: "Wind",
                        value1: "$windSpeed m/s",
                        title2: "Feels Like",
                        value2: "$feelsLike °C",
                        extraTitle: "Visibility",
                        extraValue: "$visibility KM",
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= REUSABLE INFO CARD =================
  Widget _infoCard({
    required String title1,
    required String value1,
    String? extraTitle,
    String? extraValue,
    required String title2,
    required String value2,
    Color valueColor = Colors.white,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF243447),
        borderRadius: BorderRadius.circular(14),
      ),

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title1, style: const TextStyle(color: Colors.white70)),

              Text(value1, style: TextStyle(color: valueColor, fontSize: 15)),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title2, style: const TextStyle(color: Colors.white70)),
              Text(value2, style: const TextStyle(color: Colors.white)),
            ],
          ),

          if (extraTitle != null) ...[
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(extraTitle, style: const TextStyle(color: Colors.white70)),
                Text(
                  extraValue ?? "",
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
