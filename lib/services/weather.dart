import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

class WeatherModel {
  double temperature;
  int condition;
  String cityName;

  final openWeatherApiKey = '5c732e318078556a67988a46a23f8b01';
  final openWeatherUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final openWeatherUnits = 'metric';

  Future<WeatherModel> getCityWeather(String city) async {
    var url = "$openWeatherUrl?q=$city&appid=$openWeatherApiKey&units=metric";
    final weatherJson =  await NetworkHelper.getData(url);
    this.cityName = weatherJson['name'];
    this.condition = weatherJson['weather'][0]['id'];
    this.temperature = double.parse(((weatherJson['main']['temp']
    as double)).toStringAsFixed(1)); // there isn't a better way to round in Dart :/
    return this;
  }

  Future<WeatherModel> getLocationWeather() async {
    var location = Location();
    await location.getGeoLocation();
    var url =
        "$openWeatherUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$openWeatherApiKey&units=$openWeatherUnits";

    final weatherJson =  await NetworkHelper.getData(url);
    this.cityName = weatherJson['name'];
    this.condition = weatherJson['weather'][0]['id'];
    this.temperature = double.parse(((weatherJson['main']['temp']
    as double)).toStringAsFixed(1)); // there isn't a better way to round in Dart :/
    return this;
  }

  String get weatherIcon {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String get message {
    if (temperature > 25) {
      return 'It\'s 🍦 time';
    } else if (temperature > 20) {
      return 'Time for shorts and 👕';
    } else if (temperature < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
