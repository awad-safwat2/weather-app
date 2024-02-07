import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import '../models/byhours_model.dart';
import '../models/weather_model.dart';

class WeatherServices {
  var keyValue = 'bd52098b65e742be920194542232204';
  var baseUrL = 'http://api.weatherapi.com/v1';

  Future<WeatherModel> getWeather({required String countryName}) async {
    var url = Uri.parse(
      '$baseUrL/forecast.json?key=$keyValue&q=$countryName&days=3&aqi=no&alerts=no',
    );

    http.Response? response;
    try {
      response = await http.get(url);
    } catch (er) {
      print(er);
    }

    Map<String, dynamic> data = jsonDecode(response!.body);
    WeatherModel weatherModel = WeatherModel.fromJson(data);
    return weatherModel;
  }
}
