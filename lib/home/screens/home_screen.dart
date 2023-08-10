import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/home/model/cubit/weather_cubit.dart';
import 'package:weather_app/home/widget/weather_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final cubit = context.read<WeatherCubit>();
      String myLocation = await cubit.getUserLocation();
      cubit.fetchWeatherData(myLocation);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherInitial || state is WeatherLoading) {
          return Container(
            color: Colors.white,
            child: Lottie.asset("assets/lottie/loading.json"),
          );
        } else if (state is WeatherError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    // '${state.error}',
                    'Location not found',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) {
                          return Home();
                        },
                      ));
                    },
                    child: Text('try again'),
                  ),
                ],
              ),
            ),
          );
        } else if (state is WeatherResponse) {
          var data = state.data;
          return WeatherItem(
            data: data,
          );
        }
        return Container(
          child: Lottie.asset("assets/lottie/loading.json"),
        );
      },
    );
  }
}
