import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/bydays_model.dart';
import 'package:weather_app/models/byhours_model.dart';

class WeatherModel {
  final String updateTime;
  final String updateDay;
  final double maxTemp;
  final double minTemp;
  final String conditionState;
  final String iconUrl;
  final double avgTemp;
  final String location;
  final List<ByHoursModel> hoursList;
  final List<ByDaysModel> daysList;

  // defult constractor..
  WeatherModel({
    required this.daysList,
    required this.hoursList,
    required this.updateDay,
    required this.location,
    required this.avgTemp,
    required this.updateTime,
    required this.maxTemp,
    required this.minTemp,
    required this.conditionState,
    required this.iconUrl,
  });

  // Named Constractor..
  // WeatherModel.fromJson(dynamic data) {
  //   var jsonData = data['forecast']['forecastday']['day'];
  //   location = data['location']['name'];
  //   avgTemp = jsonData['avgtemp_c'];
  //   date = data['forecast']['forecastday']['date'];
  //   maxTemp = jsonData['maxtemp_c'];
  //   minTemp = jsonData['mintemp_c'];
  //   conditionState = jsonData['condition']['text'];
  //   iconUrl = jsonData['condition']['icon'];
  // }

  // factory constructor..

  factory WeatherModel.fromJson(dynamic data) {
    List<ByDaysModel> newDaysList = [];
    var jsonDataForDays = data['forecast']['forecastday'];
    for (int i = 0; i < 3; i++) {
      newDaysList.add(ByDaysModel(
          avgTemp: jsonDataForDays[i]['day']['avgtemp_c'],
          maxTemp: jsonDataForDays[i]['day']['maxtemp_c'],
          minTemp: jsonDataForDays[i]['day']['mintemp_c'],
          time: DateFormat('EEEEE')
              .format(DateTime.parse(
                jsonDataForDays[i]['date'],
              ))
              .toString(),
          iconUrl: jsonDataForDays[i]['day']['condition']['icon']));
    }

    List<ByHoursModel> newHoursList = [];
    var jsonDataForHours = data['forecast']['forecastday'][0]['hour'];
    for (int i = 0; i < 24; i++) {
      newHoursList.add(ByHoursModel(
          avgTemp: jsonDataForHours[i]['temp_c'],
          time: DateFormat('h a')
              .format(DateTime.parse(
                jsonDataForHours[i]['time'],
              ))
              .toString(),
          iconUrl: jsonDataForHours[i]['condition']['icon']));
    }

    var jsonData = data['forecast']['forecastday'][0]['day'];

    return WeatherModel(
      daysList: newDaysList,
      hoursList: newHoursList,
      location: data['location']['name'],
      avgTemp: jsonData['avgtemp_c'],
      updateTime: DateFormat('h:mm a')
          .format(DateTime.parse(data['current']['last_updated']))
          .toString(),
      maxTemp: jsonData['maxtemp_c'],
      minTemp: jsonData['mintemp_c'],
      conditionState: jsonData['condition']['text'],
      iconUrl: jsonData['condition']['icon'],
      updateDay: DateFormat('EEEE')
          .format(DateTime.parse(data['current']['last_updated']))
          .toString(),
    );
  }

  @override
  String toString() {
    return 'Location = $location // date = $updateTime // avgTemp = $avgTemp';
  }

  MaterialColor getTehemColor() {
    if (conditionState == 'Sunny') {
      return Colors.orange;
    } else if (conditionState == 'Sleet' ||
        conditionState == 'Snow' ||
        conditionState == 'Clear') {
      return Colors.blue;
    } else if (conditionState == 'Cloudy' ||
        conditionState == 'Partly cloudy' ||
        conditionState == 'Light Cloud') {
      return Colors.grey;
    } else if (conditionState == 'Mist' ||
        conditionState == 'Ovrrcast' ||
        conditionState == 'Patchy rain possible') {
      return Colors.blueGrey;
    } else if (conditionState == 'Pathchy light rain' ||
        conditionState == 'Light rain' ||
        conditionState == 'Fog') {
      return Colors.blueGrey;
    } else {
      return Colors.cyan;
    }
  }
}
