import 'package:equatable/equatable.dart';

class Weather extends Equatable{

  final WeatherCondition weatherCondition;
  final String formattedCondition;
  final String abbreviation;
  final double minTemp;
  final double temp;
  final double maxTemp;
  final int locationId;
  final String created;
  final DateTime lastUpdated;
  final String location;
  const Weather({required this.weatherCondition, required this.formattedCondition, required this.minTemp,required this.temp,required this.maxTemp,required this.locationId,required this.created, required this.lastUpdated,required this.location, required this.abbreviation});
  @override
  // TODO: implement props
  List<Object?> get props => [
    weatherCondition,
    formattedCondition,
    minTemp,
    temp,
    maxTemp,
    locationId,
    created,
    lastUpdated,
    location,
  ];
  // factory Weather.fromJson(dynamic jsonObject){
  //   final consolidatedWeather = jsonObject["consolidate_weather"][0];
  //   return  Weather(
  //       weatherCondition: _mapStringToWeatherCondition(consolidatedWeather['weather_state_abbr']),
  //       formattedCondition: consolidatedWeather['weather_state_name'] ?? '',
  //       minTemp: consolidatedWeather['min_temp'] as double,
  //       temp: consolidatedWeather['the_temp'] as double,
  //       maxTemp: consolidatedWeather['max_temp'] as double,
  //       locationId: jsonObject['woeid'] as int, //Where On Earth Identifier = woeid
  //       created: consolidatedWeather['created'],
  //       lastUpdated: DateTime.now(),
  //       location: jsonObject['title']
  //   );
  //
  //
  // }
  factory Weather.fromJson(dynamic jsonObject) {
    final consolidatedWeather = jsonObject['consolidated_weather'][0];
    return Weather(
        weatherCondition: _mapStringToWeatherCondition(consolidatedWeather['weather_state_abbr']),
        formattedCondition: consolidatedWeather['weather_state_name'] ?? '',
        abbreviation: consolidatedWeather['weather_state_abbr'],
        minTemp: consolidatedWeather['min_temp'] as double,
        temp: consolidatedWeather['the_temp'] as double,
        maxTemp: consolidatedWeather['max_temp'] as double,
        locationId: jsonObject['woeid'] as int, //Where On Earth Identifier = woeid
        created: consolidatedWeather['created'],
        lastUpdated: DateTime.now(),
        location: jsonObject['title']
    );
  }
  factory Weather.fromJsonToday(dynamic jsonObject, String city, int locationId) {
    final consolidatedWeather = jsonObject[0];
    return Weather(
        weatherCondition: _mapStringToWeatherCondition(consolidatedWeather['weather_state_abbr']),
        formattedCondition: consolidatedWeather['weather_state_name'] ?? '',
        abbreviation: consolidatedWeather['weather_state_abbr'],
        minTemp: consolidatedWeather['min_temp'] as double,
        temp: consolidatedWeather['the_temp'] as double,
        maxTemp: consolidatedWeather['max_temp'] as double,
        locationId: locationId, //Where On Earth Identifier = woeid
        created: consolidatedWeather['created'],
        lastUpdated: DateTime.now(),
        location: city
    );
  }
  static WeatherCondition _mapStringToWeatherCondition(String inputString) {
    Map<String, WeatherCondition> map = {
      'sn': WeatherCondition.snow,
      'sl': WeatherCondition.sleet,
      'h': WeatherCondition.hail,
      't': WeatherCondition.thunderstorm,
      'hr': WeatherCondition.heavyRain,
      'lr': WeatherCondition.lightRain,
      's': WeatherCondition.showers,
      'hc': WeatherCondition.heavyCloud,
      'lc': WeatherCondition.lightCloud,
      'c': WeatherCondition.clear
    };
    return map[inputString] ?? WeatherCondition.unknown;
  }
  @override
  String toString() {
    // TODO: implement toString
    return "$temp - $weatherCondition";
  }
}
enum WeatherCondition{
  snow,
  sleet,
  hail,
  thunderstorm,
  heavyRain,
  lightRain,
  showers,
  heavyCloud,
  lightCloud,
  clear,
  unknown
}