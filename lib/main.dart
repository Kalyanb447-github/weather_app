import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/appcolors.dart';
import 'package:weather_app/apptheme.dart';
import 'package:weather_app/home/model/cubit/weather_cubit.dart';
import 'package:weather_app/home/repository/weather_repository.dart';
import 'package:weather_app/home/screens/home_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.blue,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(WeatherRepository()),
      child: MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.light,
        home: const Home(),
      ),
    );
  }
}
