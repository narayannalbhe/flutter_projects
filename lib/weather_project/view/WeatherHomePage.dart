import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({Key? key}) : super(key: key);

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  Map<String, dynamic>? weatherData;
  Map<String, dynamic>? weatherForecastData;


  TextEditingController cityController = TextEditingController();
  bool isLocationAllowed = false,
      isLocationPermissionChecked = false;
  String latitudel1 = '',
      longitudel2 = '';

  List hourlyWeatherForecast = [];
  List dailyWeatherForecast = [];
  List tommorrowWeatherForecast = [];

  String currentWeatherStatus = '';

  String weatherIcon = "";

  void initState() {
    super.initState();
    if (isLocationAllowed == false && isLocationPermissionChecked == false) {
      // _getCurrentLocation();
    }
    fetchWeatherData('Pune');
    fetchForecastData('Pune');
  }

  Future<void> fetchWeatherData(String cityName) async {
    const String API_KEY = "3b2174f9e1df41cd9f792253241204";
    String API_URL =
        "https://api.weatherapi.com/v1/current.json?key=$API_KEY&q=$cityName&aqi=no";

    try {
      final response = await http.get(Uri.parse(API_URL));
      print(response.body.toString());
      if (response.statusCode == 200) {
        setState(() {
          weatherData = jsonDecode(response.body);
        });
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchForecastData(String cityName) async {
    const String API_KEY = "3b2174f9e1df41cd9f792253241204";
    String API_URL_Forecast =
        "https://api.weatherapi.com/v1/forecast.json?key=$API_KEY&q=$cityName&aqi=no";

    try {
      final response = await http.get(Uri.parse(API_URL_Forecast));
      print(response.body.toString());
      if (response.statusCode == 200) {
        setState(() {
          weatherForecastData = jsonDecode(response.body);
        });
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image.asset('assets/menu.png', width: 35,height: 35,),
              IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                  size: 25,
                ),
                onPressed: () {},
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image.asset('asset/pin.png',width: 20,),
                  Icon(
                    Icons.location_on,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 3),
                  Text(
                    'Location',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return SingleChildScrollView(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery
                                  .of(context)
                                  .viewInsets
                                  .bottom,
                            ),
                            scrollDirection: Axis.vertical,
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        // _getCurrentLocation();
                                      },
                                      child: Text('Current Location')),
                                  TextField(
                                    controller: cityController,
                                    decoration: InputDecoration(
                                      hintText: 'Search city',
                                      border: OutlineInputBorder(),
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.search),
                                        onPressed: () {
                                          Navigator.pop(
                                              context); // Close the bottom sheet
                                          fetchWeatherData(cityController.text);
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Close'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.keyboard_arrow_down),
                  ),
                ],
              ),
              Icon(
                Icons.account_circle,
                color: Colors.blue,
                size: 40,
              ),
            ],
          ),
          weatherData != null &&
              weatherData!['current'] != null &&
              weatherData!['current']['condition'] != null
              ? Image.network(
            "https:${weatherData!['current']['condition']['icon']}",
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          )
              : SizedBox(),

          Center(
            child: weatherData != null
                ? _buildWeatherInfo()
                : CircularProgressIndicator(),
          ),

          Container(
            padding: EdgeInsets.only(top: 5),
            height: MediaQuery
                .of(context)
                .size
                .height * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 5),
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Today',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                'Forecasts',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(0.3)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: 100,
                          child: ListView.builder(
                            itemCount: weatherForecastData != null
                                ? weatherForecastData!['forecast']['forecastday']
                                .length
                                : 0,
                            itemBuilder: (BuildContext context, int index) {
                              var forecast = weatherForecastData!['forecast']['forecastday'][index];
                              var date = forecast['date'];
                              var maxTempC = forecast['day']['maxtemp_c'];
                              var minTempC = forecast['day']['mintemp_c'];

                              return ListTile(
                                title: Text('Date: $date'),
                                subtitle: Text(
                                    'Max Temp: $maxTempC°C, Min Temp: $minTempC°C'),
                              );
                            },
                          )

                      ),
                    ],
                  ),
                )


              ],
            ),
          )

        ],
      ),
    );
  }

  Widget _buildWeatherInfo() {
    final location = weatherData!['location'];
    final current = weatherData!['current'];

    String cityName = location['name'];
    String regionName = location['region'];
    String countryName = location['country'];
    double tempC = current['temp_c'].toDouble();
    double humidity = current['humidity'].toDouble();
    double windSpeedKph = current['wind_kph'].toDouble();
    double cloud = current['cloud'].toDouble();

    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.38,
      width: MediaQuery
          .of(context)
          .size
          .width,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$cityName',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    '$regionName, $countryName',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildWeatherItem(
                value: windSpeedKph,
                unit: ' Km/h',
                icon: 'assets/windspeed.png',
                label: 'Wind Speed',
              ),
              _buildWeatherItem(
                value: humidity,
                unit: '%',
                icon: 'assets/humidity.png',
                label: 'Humidity',
              ),
              _buildWeatherItem(
                value: cloud,
                unit: '%',
                icon: 'assets/cloud2.png',
                label: 'Cloud',
              ),
            ],
          ),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${tempC.toStringAsFixed(1)}°C',
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              Row(
                children: [
                  Text(
                    current['condition']['text'],
                    style: TextStyle(
                      color: Colors.deepPurple,fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(',', style: TextStyle(
                    color: Colors.deepPurple,fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),
                  SizedBox(width: 5),
                  Text(
                    DateFormat('MMMM EEE d')
                        .format(DateTime.parse(location['localtime'])),
                    style: TextStyle(
                      color: Colors.deepPurple,fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherItem({
    required double value,
    required String unit,
    required String icon,
    required String label,
  }) {
    return Column(
      children: [
        Image.asset(icon, width: 40),
        SizedBox(height: 8),
        Text(
          '${value.toInt()}$unit',
          style: TextStyle(fontSize: 16),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }

}
  /// Get Current Location API
  // _getCurrentLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     if (this.mounted) {
  //       setState(() {
  //       });
  //     }
  //     return Future.error('Location services are disabled.');
  //   }
  //
  //   permission = await Geolocator.checkPermission();
  //
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       if (this.mounted) {
  //         // _showCity=true;
  //         //_showCountry=true;
  //         isLocationAllowed = false;
  //         isLocationPermissionChecked = true;
  //         setState(() {});
  //       }
  //       return Future.error('Location permissions are denied');
  //     }
  //
  //     else if (permission == LocationPermission.deniedForever) {
  //       // Permissions are denied forever, handle appropriately.
  //       if (this.mounted) {
  //         //  _showCity=true;
  //         // _showCountry=true;
  //         isLocationAllowed = false;
  //         isLocationPermissionChecked = true;
  //         setState(() {});
  //       }
  //       return Future.error(
  //           'Location permissions are permanently denied, we cannot request permissions.');
  //     }
  //
  //     else {
  //       isLocationAllowed = true;
  //       isLocationPermissionChecked = true;
  //
  //       Position position = await Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.high);
  //
  //       if (position != null) {
  //         double latitude = position.latitude;
  //         double longitude = position.longitude;
  //
  //         List<Placemark> placemarks = await placemarkFromCoordinates(
  //           latitude, longitude, localeIdentifier: 'en_US',);
  //         if (placemarks != null) {
  //           String countrycode = placemarks[0].isoCountryCode.toString();
  //
  //           latitudel1 = latitude.toString();
  //           longitudel2 = longitude.toString();
  //
  //
  //           if (this.mounted) {
  //             setState(() {
  //               //  _showCountry=true;
  //               // _showCity=true;
  //             });
  //           }
  //         }
  //       }
  //     }
  //   }
  //
  //   else if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     if (this.mounted) {
  //       // _showCity=true;
  //       //_showCountry=true;
  //       setState(() {});
  //     }
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //
  //   else {
  //     Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);
  //
  //     if (position != null) {
  //       double latitude = position.latitude;
  //       double longitude = position.longitude;
  //
  //       List<Placemark> placemarks = await placemarkFromCoordinates(
  //           latitude, longitude);
  //       if (placemarks != null) {
  //         String countrycode = placemarks[0].isoCountryCode.toString();
  //
  //
  //         latitudel1 = latitude.toString();
  //         longitudel2 = longitude.toString();
  //         print(latitudel1);
  //         print(longitudel2);
  //
  //         if (this.mounted) {
  //           setState(() {
  //
  //           });
  //         }
  //       }
  //     }
  //   }
  // }


