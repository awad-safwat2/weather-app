import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/services/weather_service.dart';

import '../providers/weather_provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Country'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: const ButtonStyle(
                    fixedSize: MaterialStatePropertyAll(
                  Size.fromHeight(50),
                )),
                onPressed: () async {
                  LocationService locationService = LocationService();
                  await locationService.gettingLocation();
                  WeatherServices service = WeatherServices();
                  String? city =
                      locationService.placemarks?[0].administrativeArea;
                  WeatherModel weatherResult =
                      await service.getWeather(countryName: city ?? 'Sohag');
                  Provider.of<WeatherProvider>(
                    context,
                    listen: false,
                  ).weatherProvModel = weatherResult;

                  Navigator.pop(context);
                },
                child: const Text('Get My Location'),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Otherwise Search for a city',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                onFieldSubmitted: (cityName) async {
                  WeatherServices service = WeatherServices();

                  WeatherModel weatherResult =
                      await service.getWeather(countryName: cityName);
                  Provider.of<WeatherProvider>(
                    context,
                    listen: false,
                  ).weatherProvModel = weatherResult;

                  Navigator.pop(context);
                },
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 35, horizontal: 8),
                  hintText: 'Enter The Country Name',
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  label: Text('Search'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
