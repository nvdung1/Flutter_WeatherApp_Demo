import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app/models/weather.dart';
const baseUrl= 'https://www.metaweather.com';
final locationUrl= (city) =>'$baseUrl/api/location/search/?query=$city';
final weatherUrl= (locationId)=> '$baseUrl/api/location/$locationId';
final weatherTodayUrl= (locationId, date)=>'$baseUrl/api/location/$locationId/$date/';
class WeatherRepositories{
 var  httpClient = http.Client();
 WeatherRepositories({required this.httpClient});
 // lấy id của địa điểm
 Future<int> getLocationIdFromCity(String city) async {
  final response= await this.httpClient.get(Uri.parse(locationUrl(city)));
  if(response.statusCode==200){
   final cities= jsonDecode(response.body) as List;
   return (cities.first)['woeid'] ?? Map();
  }else{
   throw Exception("Error getting location id of: $city");
  }
 }
 Future<Weather> fetchWeather(int locationId) async{
  final response= await this.httpClient.get(Uri.parse(weatherUrl(locationId)));
  if(response.statusCode != 200) {
   throw Exception('Error getting weather from locationId: $locationId');
  }
  final weatherJson = jsonDecode(response.body);
  return Weather.fromJson(weatherJson);
 }
 // lấy thông tin weather
 Future<Weather> getWeatherFromCity(String city) async {
  final int locationId = await getLocationIdFromCity(city);
  return fetchWeather(locationId);
 }
 Future<Weather> fetchWeatherToday(int locationId, String today, String city) async{
  final response= await this.httpClient.get(Uri.parse(weatherTodayUrl(locationId,today)));
  if(response.statusCode != 200) {
   throw Exception('Error getting weather from locationId: $locationId');
  }
  final weatherJson = jsonDecode(response.body);
  return Weather.fromJsonToday(weatherJson,city,locationId);
 }
 Future<Weather> getWeatherTodayFromCity(String city, String today) async {
  final int locationId = await getLocationIdFromCity(city);
  return fetchWeatherToday(locationId,today,city);
 }
 Future<List<Weather>> getWeatherOfWeek(String city) async{
  var today = new DateTime.now();
  List<Weather> listWeatherToday=[];
  for(var i = 0; i < 7; i++){
   String day= new DateFormat('y/M/d').format(today.add(new Duration(days: i + 1))).toString();
   final Weather weatherToday = await getWeatherTodayFromCity(city, day);
   listWeatherToday.add(weatherToday);
  }
  return listWeatherToday;
 }
}