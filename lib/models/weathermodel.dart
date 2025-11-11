class WeatherModel {
  String cityname;
  DateTime date;
  String? image;
  double temp;
  double maxtemp;
  double mintemp;
  String weathercondition;
  WeatherModel({
    required this.cityname,
    required this.date,
    this.image,
    required this.temp,
    required this.maxtemp,
    required this.mintemp,
    required this.weathercondition,
  });
  factory WeatherModel.fromjson(json) {
    return WeatherModel(
        cityname: json['location']['name'],
        date: DateTime.parse(json['location']['localtime']),
        temp: json['forecast']['forecastday'][0]['day']['avgtemp_c'],
        maxtemp: json['forecast']['forecastday'][0]['day']['maxtemp_c'],
        mintemp: json['forecast']['forecastday'][0]['day']['mintemp_c'],
        weathercondition: json['forecast']['forecastday'][0]['day']['condition']
            ['text']);
  }
}
