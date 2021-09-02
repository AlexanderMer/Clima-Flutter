import 'package:clima/services/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  static Future getData(String url) async {
    final _url = Uri.parse(url);
    final response = await http.get(_url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
  }
}
