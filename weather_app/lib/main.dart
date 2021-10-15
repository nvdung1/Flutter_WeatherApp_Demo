import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/setting_bloc.dart';
import 'package:weather_app/blocs/theme_bloc.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/blocs/weather_bloc_observer.dart';
import 'package:weather_app/repositories/weather_repositories.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/screens/setting_screen.dart';
import 'package:weather_app/screens/weather_screen.dart';
void main() {
  Bloc.observer= WeatherBlocObserver();
  final WeatherRepositories weatherRepositories= WeatherRepositories(httpClient: http.Client());
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ThemeBloc>(create: (context) => ThemeBloc(),),
      BlocProvider<SettingBloc>(create: (context) => SettingBloc(),),
    ],
    child: MyApp(weatherRepositories: weatherRepositories,),
  ));
}

class MyApp extends StatelessWidget {
  final WeatherRepositories weatherRepositories;
  MyApp({Key? key,required this.weatherRepositories}):super(key:key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        SettingScreen.routerName:(context)=> SettingScreen(),
      },
      title: 'Flutter Demo',
      home: BlocProvider(
        create: (context)=> WeatherBloc(weatherRepositories: weatherRepositories),
        child: WeatherScreen(),
      ),
    );
  }
}