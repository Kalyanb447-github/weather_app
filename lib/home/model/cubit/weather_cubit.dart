import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/home/model/weather_model.dart';
import 'package:weather_app/home/repository/weather_repository.dart';
import 'package:geolocator/geolocator.dart';
part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _repository;
  WeatherCubit(this._repository) : super(WeatherInitial());

  Future<void> fetchWeatherData(String query) async {
    emit(WeatherLoading());
    try {
      final response = await _repository.getWeatherData(query);
      emit(WeatherResponse(response));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }

  Future<String> getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    var first = placemarks.first;
    print(first);

    return first.street ?? 'siliguri';
  }
}
