import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherModel? _weatherProvModel;

  set weatherProvModel(WeatherModel? weathermodel) {
    _weatherProvModel = weathermodel;
    notifyListeners();
  }

  WeatherModel? get weatherProvModel {
    return _weatherProvModel;
  }
}
