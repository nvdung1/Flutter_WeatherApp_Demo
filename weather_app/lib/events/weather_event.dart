import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable{
  const WeatherEvent();
}
class WeatherEventBegin extends WeatherEvent{
  final String city;
  const WeatherEventBegin({required this.city});
  @override
  List<Object?> get props => [city];
}
class WeatherEventRequested extends WeatherEvent{
  final String city;
  const WeatherEventRequested({required this.city});
  @override
  List<Object?> get props => [city];
}
class WeatherEventRefresh extends WeatherEvent{
  final String city;
  const WeatherEventRefresh({required this.city});
  @override
  List<Object?> get props => [city];
}