import 'package:dio/dio.dart';
import 'package:weather_app/home/model/weather_model.dart';

class WeatherRepository {
  Future<Weather> getWeatherData(String query) async {
    String url =
        "http://api.weatherstack.com/current?access_key=2f88506187bcc9bdca0e2865ae1a4756&query=$query";
    Dio dio = Dio();
    final response = await dio.get(url);
    final data = Weather.fromMap(response.data);
    return data;
  }
}
