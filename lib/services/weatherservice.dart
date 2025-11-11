import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:weatherapp/models/weathermodel.dart';

class WeatherService {
  WeatherService({required this.dio});
  Dio dio;
  String apikey = 'fca07a3da6094631bcb35500252104';
  String baseurl = 'http://api.weatherapi.com/v1';
  //http://api.weatherapi.com/v1/forecast.json?key=fca07a3da6094631bcb35500252104&q=cairo

  Future<WeatherModel> getcurrentweather({required String cityname}) async {
    try {
      Response response =
          await dio.get('$baseurl/forecast.json?key=$apikey&q=$cityname');
      WeatherModel weatherModel = WeatherModel.fromjson(response.data);
      return weatherModel;
    } on DioException catch (e) {
      final String errmessage = e.response?.data['error']['message'] ??
          'oops!! , an error is occurd , try later please ';
      throw Exception(errmessage);
    } catch (e) {
      log(e.toString());
      throw Exception('oops!! , an error is occurd , try later please ');
    }
  }
}
