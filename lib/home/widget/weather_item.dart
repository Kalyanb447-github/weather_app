import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/home/model/weather_model.dart';

import '../model/cubit/weather_cubit.dart';

class WeatherItem extends StatefulWidget {
  const WeatherItem({super.key, required this.data});

  final Weather data;

  @override
  State<WeatherItem> createState() => _WeatherItemState();
}

class _WeatherItemState extends State<WeatherItem> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    String _uvIndex() {
      var uv = widget.data.current.uvIndex;
      if (uv >= 1 && uv <= 2) {
        return "Low";
      }
      if (uv >= 3 && uv <= 5) {
        return "Medium";
      }
      if (uv >= 6 && uv <= 7) {
        return "High";
      }
      if (uv >= 8 && uv <= 10) {
        return "Very High";
      }
      if (uv >= 11) {
        return "Extremely High";
      }
      return "";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.data.location.name,
          style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
                fontSize: 28,
              ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: Text('Search for a location'),
                        content: TextField(
                          controller: textEditingController,
                        ),
                        actions: [
                          IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              final cubit = context.read<WeatherCubit>();

                              if (textEditingController.text.isNotEmpty) {
                                Navigator.pop(context);

                                cubit.fetchWeatherData(
                                    textEditingController.text);
                              }
                            },
                          ),
                        ],
                      ));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 0,
            left: 12,
            right: 12,
            bottom: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Lottie.asset('assets/lottie/Windy.json', height: 200),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.current.temperature.toString(),
                        style: textTheme.titleMedium!.copyWith(
                          fontSize: 150,
                          height: 1.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "\u2103",
                        style: textTheme.titleMedium!.copyWith(
                          fontSize: 50,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white.withAlpha(50),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.shower_outlined,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${widget.data.current.cloudcover}%",
                                style: textTheme.titleMedium!
                                    .copyWith(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white.withAlpha(50),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.air,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${widget.data.current.feelslike}\u2103",
                                style: textTheme.titleMedium!
                                    .copyWith(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Text(
                widget.data.current.weatherDescriptions[0],
                style: textTheme.titleMedium!.copyWith(
                  fontSize: 35,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              // Row(
              //   children: [
              //     const Icon(
              //       Icons.arrow_upward,
              //       color: Colors.white,
              //     ),
              //     Text(
              //       "30",
              //       style: textTheme.titleMedium!.copyWith(fontSize: 20),
              //     ),
              //     Text(
              //       "\u2103",
              //       style: textTheme.titleMedium!.copyWith(
              //         fontSize: 20,
              //         fontWeight: FontWeight.normal,
              //       ),
              //       textAlign: TextAlign.start,
              //     ),
              //     const SizedBox(
              //       width: 20,
              //     ),
              //     const Icon(
              //       Icons.arrow_downward,
              //       color: Colors.white,
              //     ),
              //     Text(
              //       "30",
              //       style: textTheme.titleMedium!.copyWith(fontSize: 20),
              //     ),
              //     Text(
              //       "\u2103",
              //       style: textTheme.titleMedium!.copyWith(
              //         fontSize: 20,
              //       ),
              //       textAlign: TextAlign.start,
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white.withAlpha(50),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 15),
                      child: Text(
                        "DETAILS",
                        style: textTheme.titleMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Precipitation",
                                style: textTheme.titleMedium!.copyWith(
                                    color: Colors.white.withAlpha(90)),
                              ),
                              Text(
                                "${widget.data.current.precip} mm",
                                style: textTheme.titleMedium!
                                    .copyWith(fontSize: 16),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "HUM",
                                style: textTheme.titleMedium!.copyWith(
                                    color: Colors.white.withAlpha(90)),
                              ),
                              Text(
                                "${widget.data.current.humidity}%",
                                style: textTheme.titleMedium!
                                    .copyWith(fontSize: 16),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "UV",
                                style: textTheme.titleMedium!.copyWith(
                                    color: Colors.white.withAlpha(90)),
                              ),
                              Text(
                                _uvIndex(),
                                style: textTheme.titleMedium!
                                    .copyWith(fontSize: 16),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "SW wind",
                                style: textTheme.titleMedium!.copyWith(
                                    color: Colors.white.withAlpha(90)),
                              ),
                              Text(
                                "${widget.data.current.windSpeed} km/h",
                                style: textTheme.titleMedium!
                                    .copyWith(fontSize: 16),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Visibility",
                                style: textTheme.titleMedium!.copyWith(
                                    color: Colors.white.withAlpha(90)),
                              ),
                              Text(
                                "${widget.data.current.visibility} km",
                                style: textTheme.titleMedium!
                                    .copyWith(fontSize: 16),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Pressure",
                                style: textTheme.titleMedium!.copyWith(
                                    color: Colors.white.withAlpha(90)),
                              ),
                              Text(
                                "${widget.data.current.pressure} hPa",
                                style: textTheme.titleMedium!
                                    .copyWith(fontSize: 16),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
