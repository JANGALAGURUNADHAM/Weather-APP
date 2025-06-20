import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MyApp());
}

// 🌗 APP WRAPPER with theme toggle
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      themeMode: _themeMode,
      home: WeatherHome(
        isDarkMode: _themeMode == ThemeMode.dark,
        onToggleTheme: toggleTheme,
      ),
    );
  }
}

// 🏠 WEATHER HOME
class WeatherHome extends StatefulWidget {
  final void Function(bool)? onToggleTheme;
  final bool isDarkMode;

  const WeatherHome({super.key, this.onToggleTheme, required this.isDarkMode});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  final TextEditingController cityController = TextEditingController();
  Map<String, dynamic>? weatherData;
  List<String> recentCities = [];

  bool isLoading = false;
  String error = "";

  @override
  void initState() {
    super.initState();
    loadRecentCities();
  }

  Future<void> fetchWeather(String cityName) async {
    if (cityName.trim().isEmpty) return;

    setState(() {
      isLoading = true;
      error = "";
    });

    try {
      final apiKey = '302eadb7d9732d4128a587d0abed12f7';
      final url =
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          weatherData = data;
          isLoading = false;
        });
        saveCity(cityName);
      } else {
        setState(() {
          error = "City not found!";
          isLoading = false;
          weatherData = null;
        });
      }
    } catch (e) {
      setState(() {
        error = "Something went wrong. Please try again.";
        isLoading = false;
        weatherData = null;
      });
    }
  }

  Future<void> saveCity(String city) async {
    final prefs = await SharedPreferences.getInstance();
    if (city.isEmpty || recentCities.contains(city)) return;

    recentCities.insert(0, city);
    if (recentCities.length > 5) {
      recentCities = recentCities.sublist(0, 5);
    }

    await prefs.setStringList('recentCities', recentCities);
    setState(() {});
  }

  Future<void> loadRecentCities() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      recentCities = prefs.getStringList('recentCities') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        actions: [
          Switch(
            value: widget.isDarkMode,
            onChanged: (value) {
              if (widget.onToggleTheme != null) {
                widget.onToggleTheme!(value);
              }
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          if (cityController.text.isNotEmpty) {
            await fetchWeather(cityController.text);
          }
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: cityController,
                decoration: const InputDecoration(
                  labelText: "Enter city name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  fetchWeather(cityController.text);
                },
                child: const Text("Search"),
              ),
              const SizedBox(height: 30),
              if (isLoading) const CircularProgressIndicator(),
              if (error.isNotEmpty)
                Text(error,
                    style: const TextStyle(color: Colors.red, fontSize: 16)),
              if (weatherData != null && !isLoading)
                buildWeatherCard(weatherData!),
              const SizedBox(height: 20),
              if (recentCities.isNotEmpty) ...[
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Recent Cities:",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                ...recentCities.map((city) => ListTile(
                      title: Text(city),
                      leading: const Icon(Icons.location_city),
                      onTap: () {
                        cityController.text = city;
                        fetchWeather(city);
                      },
                    )),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget buildWeatherCard(Map<String, dynamic> data) {
    final temp = data['main']['temp'];
    final condition = data['weather'][0]['main'];
    final city = data['name'];
    final iconCode = data['weather'][0]['icon'];
    final iconUrl = 'https://openweathermap.org/img/wn/$iconCode@2x.png';
    final lat = data['coord']['lat'];
    final lon = data['coord']['lon'];

    return Column(
      children: [
        Card(
          margin: const EdgeInsets.only(top: 16),
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: Image.network(iconUrl),
            title: Text(
              city,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text("$condition • ${temp.toString()}°C"),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: FlutterMap(
            options: MapOptions(
              center: LatLng(lat, lon),
              zoom: 10,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.weather_app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(lat, lon),
                    width: 80,
                    height: 80,
                    child: const Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
