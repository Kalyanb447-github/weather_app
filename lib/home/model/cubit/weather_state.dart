part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherError extends WeatherState {
  String error;
  WeatherError(this.error);
}

class WeatherResponse extends WeatherState {
  Weather data;
  WeatherResponse(this.data);
}
