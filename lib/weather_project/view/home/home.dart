import 'dart:convert';
import 'dart:ui';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter_projects/weather_project/components/weather_item.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _cityController = TextEditingController();

  static String API_KEY = "3b2174f9e1df41cd9f792253241204";

  String location = "Pune";
  String weatherIcon = 'assets/png/heavycloud.png';
  int temp = 0;
  int humidity = 0;
  int windSpeed = 0;
  int cloud = 0;
  String currentDate = "";

  List hourlyWeatherForecast = [];
  List dailyWeatherForecast = [];
  List tommorrowWeatherForecast = [];

  String currentWeatherStatus = '';

  //api call
  String searchWeatherApi = "https://api.weatherapi.com/v1/current.json?key=" +
      API_KEY +
      "&days=7&q=";

  void fetchWeatherData(String searchText) async {
    try {
      var searchResult =
          await http.get(Uri.parse(searchWeatherApi + searchText));

      final weatherData = Map<String, dynamic>.from(
          json.decode(searchResult.body) ?? 'No Data');
      var locationData = weatherData['location'];
      var currentWeather = weatherData['current'];

      setState(() {
        location = getShortLocationName(locationData['name']);
      });

      var parseDate = DateTime.parse(locationData["location"].substring(0, 10));
      var newDate = DateFormat("MMMMEEEd").format(parseDate);
      currentDate = newDate;

      //update weather
      currentWeatherStatus = currentWeather['condition']['text'];
      weatherIcon =
          currentWeatherStatus.replaceAll('', '').toLowerCase() + '.png';

      temp = currentWeather['temp_c'].toInt();
      humidity = currentWeather['humidity'].toInt();
      windSpeed = currentWeather['wind_kph'].toInt();
      cloud = currentWeather['cloud'].toInt();

      // update hourly weather forecast
      dailyWeatherForecast = weatherData['forecast']['forecastday'];
      hourlyWeatherForecast = dailyWeatherForecast[0]['hour'];
      print(dailyWeatherForecast);
    } catch (e) {
      print(e);
    }
  }

  static String getShortLocationName(String s) {
    List<String> wordList = s.split('');

    if (wordList.isNotEmpty) {
      if (wordList.length > 1) {
        return wordList[0] + '' + wordList[1];
      } else {
        return wordList[0];
      }
    } else {
      return " ";
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // width  = MediaQuery.of(context).size.width * 1;
    // height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.deepPurple.withOpacity(0.4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                height: size.height * 0.7,
                decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Image.asset('assets/menu.png', width: 35,height: 35,),
                        IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: Colors.white,
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            IconButton(
                                // onPressed: () {
                                //   _cityController.clear();
                                //   showBarModalBottomSheet(
                                //       context: context,
                                //       builder: (context) =>
                                //           SingleChildScrollView(
                                //             controller:
                                //                 ModalScrollController.of(
                                //                     context),
                                //             child: Container(
                                //               height: size.height * 0.2,
                                //               padding:
                                //                   const EdgeInsets.symmetric(
                                //                 horizontal: 20,
                                //                 vertical: 10,
                                //               ),
                                //               child: Column(
                                //                 children: [
                                //                   SizedBox(
                                //                     width: 70,
                                //                     child: Divider(
                                //                       thickness: 3.5,
                                //                       color: Colors.blue,
                                //                     ),
                                //                   ),
                                //                   SizedBox(height: 10),
                                //                   TextField(
                                //                     onChanged: (searchText) {
                                //                       fetchWeatherData(
                                //                           searchText);
                                //                     },
                                //                     controller: _cityController,
                                //                     autofocus: true,
                                //                     decoration: InputDecoration(
                                //                       prefixIcon: Icon(
                                //                         Icons.search,
                                //                         color: Colors.red,
                                //                       ),
                                //                       suffixIcon:
                                //                           GestureDetector(
                                //                         onTap: () =>
                                //                             _cityController
                                //                                 .clear(),
                                //                         child: Icon(
                                //                           Icons.close,
                                //                           color: Colors.green,
                                //                         ),
                                //                       ),
                                //                     ),
                                //                   )
                                //                 ],
                                //               ),
                                //             ),
                                //           ));
                                // },
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Search Location'),
                                        content: Container(
                                          height: MediaQuery.of(context).size.height * 0.2,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                width: 70,
                                                child: Divider(
                                                  thickness: 3.5,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              TextField(
                                                onChanged: (searchText) {
                                                  // Replace this with your logic
                                                  print('Search Text: $searchText');
                                                  fetchWeatherData(searchText);
                                                },
                                                controller: _cityController,
                                                autofocus: true,
                                                decoration: InputDecoration(
                                                  prefixIcon: Icon(
                                                    Icons.search,
                                                    color: Colors.red,
                                                  ),
                                                  suffixIcon: GestureDetector(
                                                    onTap: () => _cityController.clear(),
                                                    child: Icon(
                                                      Icons.close,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Close'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(10),
                        //   child: Image.asset(
                        //     "assets/profile.png",
                        //     width: 35,height: 35,),
                        // )
                        Icon(
                          Icons.account_circle,
                          color: Colors.white,
                          size: 40,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 100,
                      child: Image.asset(
                        "assets/cloud.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            temp.toString(),
                            style: TextStyle(
                                fontSize: 80,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow),
                          ),
                        ),
                        Text(
                          '0',
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow),
                        ),
                        Text(
                          currentWeatherStatus,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          currentDate,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          color: Colors.white70,
                        )),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          WeatherItem(
                              value: windSpeed.toInt(),
                              unit: ' Km/h',
                              imageURL: 'assets/windspeed.png'),
                          WeatherItem(
                              value: humidity.toInt(),
                              unit: ' Km/h',
                              imageURL: 'assets/humidity.png'),
                          WeatherItem(
                              value: cloud.toInt(),
                              unit: ' Km/h',
                              imageURL: 'assets/cloud2.png'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5),
              height: size.height * 0.2,
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
                    height: 5,
                  ),
                  SizedBox(
                    height: 110,
                    child: ListView.builder(
                        itemCount: hourlyWeatherForecast.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          String currentTime =
                              DateFormat('HH:mm:ss').format(DateTime.now());
                          String currentHour = currentTime.substring(0, 2);
                          String forecastTime = hourlyWeatherForecast[index]
                                  ['time']
                              .substring(11, 16);

                          String forecastHour = hourlyWeatherForecast[index]
                                  ['time']
                              .substring(11, 13);

                          String forecastWeatherName =
                              hourlyWeatherForecast[index]["condition"]["text"];
                          String forecastWeatherIcon = forecastWeatherName
                                  .replaceAll('', '')
                                  .toLowerCase() +
                              ".png";

                          String forecastTempreture =
                              hourlyWeatherForecast[index]["temp_c"]
                                  .round()
                                  .toString();

                          return Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            margin: EdgeInsets.only(right: 20),
                            width: 60,
                            decoration: BoxDecoration(
                              color: currentHour == forecastHour
                                  ? Colors.green
                                  : Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  forecastTime,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                                Image.asset(
                                  'assets/$forecastWeatherIcon',
                                  width: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      forecastTempreture,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          color: Colors.grey),
                                    ),
                                    Text(
                                      '0',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
