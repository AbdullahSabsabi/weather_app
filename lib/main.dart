import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/cubits/getweathercubit/getweathercubit.dart';
import 'package:weatherapp/cubits/getweathercubit/getweatherstates.dart';
import 'package:weatherapp/views/homeview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherCubit(),
      child: BlocBuilder<GetWeatherCubit, WeatherState>(
        builder: (context, state) {
          final cubit = BlocProvider.of<GetWeatherCubit>(context);
          final condition = cubit.weathermodel?.weathercondition ?? '';
          final themeColor = getThemeColor(condition);

          return MaterialApp(
            theme: ThemeData(
              primarySwatch: themeColor,
            ),
            debugShowCheckedModeBanner: false,
            home: HomeView(),
          );
        },
      ),
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
