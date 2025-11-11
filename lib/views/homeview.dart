import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/cubits/getweathercubit/getweathercubit.dart';
import 'package:weatherapp/cubits/getweathercubit/getweatherstates.dart';
import 'package:weatherapp/views/noweatherbody.dart';
import 'package:weatherapp/views/searchview.dart';
import 'package:weatherapp/views/weatherinfobody.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather App'), actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SearchView(),
              ));
            },
            icon: Icon(Icons.search))
      ]),
      body: BlocBuilder<GetWeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherInitialState) {
            return NoWeatherBody();
          } else if (state is WeatherLoadedState) {
            return WeatherInfoBody();
          } else {
            return Center(
                child: Text(
              'oops , an error occurd',
              style: TextStyle(fontSize: 25),
            ));
          }
        },
      ),
    );
  }
}
