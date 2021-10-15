import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/events/theme_event.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/state/theme_state.dart';
import 'package:flutter/material.dart';
class ThemeBloc extends Bloc<ThemeEvent, ThemeState>{

  ThemeBloc() : super(ThemeState(image: AssetImage('assets/images/hail.png')));
  @override
  Stream<ThemeState> mapEventToState(ThemeEvent themeEvent) async*{
    ThemeState newThemeState;
    if(themeEvent is ThemeEventWeatherChanged){
      final weatherCondition = themeEvent.weatherCondition;
      if(weatherCondition == WeatherCondition.clear ){
        newThemeState= ThemeState(
            image: AssetImage('assets/images/clear.png')

        );
      }else if(weatherCondition == WeatherCondition.lightCloud) {
        newThemeState = ThemeState(
            image: AssetImage('assets/images/lightcloud.png')
        );
      }else if(weatherCondition == WeatherCondition.snow) {
        newThemeState = ThemeState(
            image: AssetImage('assets/images/snow.png')
        );
      }else if(weatherCondition == WeatherCondition.sleet) {
        newThemeState = ThemeState(
            image: AssetImage('assets/images/sleet.png')
        );
      }
      else if(weatherCondition == WeatherCondition.hail) {
        newThemeState = ThemeState(
            image: AssetImage('assets/images/hail.png')
        );
      }  else if(weatherCondition == WeatherCondition.heavyCloud) {
        newThemeState = ThemeState(
            image: AssetImage('assets/images/heavycloud.png')
        );
      }else if( weatherCondition == WeatherCondition.lightRain ) {
        newThemeState = ThemeState(
            image: AssetImage('assets/images/lightrain.png')
        );
      }
      else if(weatherCondition == WeatherCondition.showers ) {
        newThemeState = ThemeState(
            image: AssetImage('assets/images/showers.png')
        );
      }
      else if(weatherCondition == WeatherCondition.heavyRain ) {
        newThemeState = ThemeState(
            image: AssetImage('assets/images/heavyrain.png')
        );
      }else if(weatherCondition == WeatherCondition.thunderstorm) {
        newThemeState = ThemeState(
            image: AssetImage('assets/images/hail.png')
        );
      } else {
        newThemeState = ThemeState(
            image: AssetImage('assets/images/clear.png')
        );
      }
      yield newThemeState;
    }
  }
}