import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Location location;
  WeatherModel weather;

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  void getLocation() async {
    var location = Location();
    await location.getGeoLocation();
    this.location = location;

    var openWeatherApiKey = '5c732e318078556a67988a46a23f8b01';
    var url =
        "https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$openWeatherApiKey&units=metric";

    final weatherJson = await NetworkHelper.getData(url);
    final weather = WeatherModel();

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LocationScreen(
      weatherData: weatherJson
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SpinKitSpinningLines(
      color: Colors.white,
      size: 50.0,

    )));
  }
}
