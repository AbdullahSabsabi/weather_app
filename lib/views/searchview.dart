import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/cubits/getweathercubit/getweathercubit.dart';
import 'package:weatherapp/cubits/getweathercubit/getweatherstates.dart';
import 'package:weatherapp/models/weathermodel.dart';
import 'package:weatherapp/services/weatherservice.dart';
import 'package:weatherapp/views/homeview.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search  city')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: TextField(
            onSubmitted: (value) async {
              var getweathercubit = BlocProvider.of<GetWeatherCubit>(context);
              await getweathercubit.getWeather(cityname: value);

              // تحقق إذا كانت الحالة تم تحميلها
              if (getweathercubit.state is WeatherLoadedState) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HomeView(),
                  ),
                );
              } else if (getweathercubit.state is WeatherFailurState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('فشل في جلب بيانات الطقس')),
                );
              }
            },
            decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                hintText: 'Enter City Name',
                labelText: 'Search',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 30)),
          ),
        ),
      ),
    );
  }
}
