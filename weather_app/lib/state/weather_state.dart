import 'package:equatable/equatable.dart';
import 'package:weather_app/models/weather.dart';

abstract class WeatherState extends Equatable{
  const WeatherState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class WeatherStateInitial extends WeatherState{}
class WeatherStateLoading extends WeatherState{}
// ignore: must_be_immutable
class WeatherStateSuccess extends WeatherState{
  final Weather weather;
  List<Weather> weatherToday=[];
  WeatherStateSuccess({required this.weather,required this.weatherToday});
  @override
  // TODO: implement props
  List<Object?> get props => [weather];
}
class WeatherStateFailure extends WeatherState{}