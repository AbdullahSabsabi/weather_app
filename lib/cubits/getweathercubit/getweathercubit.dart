import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/cubits/getweathercubit/getweatherstates.dart';
import 'package:weatherapp/models/weathermodel.dart';

import '../../services/weatherservice.dart';
import '../../views/searchview.dart';

class GetWeatherCubit extends Cubit<WeatherState> {
  GetWeatherCubit() : super(WeatherInitialState());
  WeatherModel? weathermodel;

  getWeather({required String cityname}) async {
    try {
      weathermodel = await WeatherService(dio: Dio())
          .getcurrentweather(cityname: cityname);
      emit(WeatherLoadedState());
    } catch (e) {
      emit(WeatherFailurState());
    }
  }
}
