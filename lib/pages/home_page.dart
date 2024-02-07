import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_page.dart';
import 'package:weather_app/providers/weather_provider.dart';

import '../custom_widget/number_and_degree.dart';

class HomePage extends StatelessWidget {
  WeatherModel? weatherProvModelData;

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    weatherProvModelData =
        Provider.of<WeatherProvider>(context).weatherProvModel;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          weatherProvModelData?.location ?? 'Weather App',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                ),
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: (weatherProvModelData == null)
          ? Container(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'there is no weather😔',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    const Text(
                      'start searching now 🔍',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchPage(),
                        ),
                      ),
                      child: const Text('Search'),
                    )
                  ],
                ),
              ),
            )
          : Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                weatherProvModelData!.getTehemColor()[500]!,
                weatherProvModelData!.getTehemColor()[300]!,
                weatherProvModelData!.getTehemColor()[100]!,
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.all(5)),
                  Text(
                    'Last Update: ${weatherProvModelData!.updateTime}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.network(
                        'http:${weatherProvModelData!.iconUrl.toString()}',
                        fit: BoxFit.cover,
                      ),
                      NumberAndDegree(
                        tempNumber:
                            weatherProvModelData!.avgTemp.toInt().toString(),
                        numberSize: 50,
                        degreeSize: 50,
                      ),
                      Column(
                        children: [
                          NumberAndDegree(
                            tempNumber:
                                'max :${weatherProvModelData?.maxTemp.toInt() ?? ''}',
                            numberSize: 18,
                            degreeSize: 20,
                          ),
                          NumberAndDegree(
                            tempNumber:
                                'min :${weatherProvModelData?.minTemp.toInt() ?? ''}',
                            numberSize: 18,
                            degreeSize: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    weatherProvModelData!.conditionState,
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Divider(
                    height: 2,
                    color: Colors.black,
                    endIndent: 25,
                    indent: 25,
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        scrollDirection: Axis.horizontal,
                        itemCount: weatherProvModelData!.hoursList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 3,
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  weatherProvModelData!.hoursList[index].time,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Image.network(
                                  'http:${weatherProvModelData!.hoursList[index].iconUrl.toString()}',
                                  fit: BoxFit.cover,
                                ),
                                NumberAndDegree(
                                  tempNumber:
                                      '${weatherProvModelData?.hoursList[index].avgTemp.toInt() ?? ''}',
                                  numberSize: 18,
                                  degreeSize: 20,
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Divider(
                    height: 2,
                    color: Colors.black,
                    endIndent: 25,
                    indent: 25,
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: weatherProvModelData!.daysList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 1,
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  weatherProvModelData!.daysList[index].time,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                NumberAndDegree(
                                  tempNumber: weatherProvModelData!
                                      .daysList[index].avgTemp
                                      .toString(),
                                  numberSize: 18,
                                  degreeSize: 20,
                                ),
                                Image.network(
                                  'http:${weatherProvModelData!.daysList[index].iconUrl.toString()}',
                                  fit: BoxFit.cover,
                                ),
                                NumberAndDegree(
                                  tempNumber: weatherProvModelData!
                                      .daysList[index].maxTemp
                                      .toString(),
                                  numberSize: 15,
                                  degreeSize: 18,
                                ),
                                const Text('/'),
                                NumberAndDegree(
                                  tempNumber: weatherProvModelData!
                                      .daysList[index].minTemp
                                      .toString(),
                                  numberSize: 15,
                                  degreeSize: 18,
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
    );
  }
}
