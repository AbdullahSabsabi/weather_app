import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/main.dart';
import 'package:weatherapp/models/weathermodel.dart';

import '../cubits/getweathercubit/getweathercubit.dart';
import '../cubits/getweathercubit/getweatherstates.dart';

class WeatherInfoBody extends StatelessWidget {
  const WeatherInfoBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetWeatherCubit, WeatherState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<GetWeatherCubit>(context);

        if (state is WeatherLoadedState && cubit.weathermodel != null) {
          final weather = cubit.weathermodel!;
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  getThemeColor(weather.weathercondition),
                  getThemeColor(weather.weathercondition)[300]!,
                  getThemeColor(weather.weathercondition)[100]!,
                ])),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    weather.cityname,
                    style: const TextStyle(
                        fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                      'updated at : ${weather.date.hour} : ${weather.date.minute}',
                      style: const TextStyle(fontSize: 25)),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(classifyWeatherByTemp(weather.temp),
                          width: 80),
                      Text(
                        weather.temp.toString(),
                        style: const TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children: [
                          Text('Maxtemp : ${weather.maxtemp.round()}',
                              style: const TextStyle(fontSize: 15)),
                          Text('Mintemp : ${weather.mintemp.round()}',
                              style: const TextStyle(fontSize: 15)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text(
                    weather.weathercondition,
                    style: const TextStyle(
                        fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        } else if (state is WeatherFailurState) {
          return const Center(child: Text('فشل تحميل الطقس'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

MaterialColor getThemeColor(String condition) {
  condition = condition.toLowerCase();

  if (condition.contains('sunny') || condition.contains('clear')) {
    return Colors.amber;
  } else if (condition.contains('cloudy') || condition.contains('overcast')) {
    return Colors.blueGrey;
  } else if (condition.contains('rain') ||
      condition.contains('drizzle') ||
      condition.contains('shower')) {
    return Colors.blue;
  } else if (condition.contains('snow') ||
      condition.contains('blizzard') ||
      condition.contains('sleet')) {
    return Colors.cyan;
  } else if (condition.contains('thunder')) {
    return Colors.deepPurple;
  } else if (condition.contains('fog') || condition.contains('mist')) {
    return Colors.grey;
  } else {
    return Colors.blue;
  }
}

String classifyWeatherByTemp(double temp) {
  if (temp <= 0) {
    return 'assets/images/snow.png';
  } else if (temp > 0 && temp <= 15) {
    return 'assets/images/cloudy.png';
  } else if (temp > 15 && temp <= 25) {
    return 'assets/images/rainy.png';
  } else if (temp > 25 && temp <= 35) {
    return 'assets/images/thunderstorm.png';
  } else {
    return 'assets/images/clear.png';
  }
}
