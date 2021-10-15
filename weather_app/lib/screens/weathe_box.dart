import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/blocs/setting_bloc.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/state/setting_state.dart';

// ignore: must_be_immutable
class WeatherBox extends StatelessWidget{
  final Weather weather;
  var daysFromNow;
  WeatherBox({Key? key,required this.weather, required this.daysFromNow}):super(key: key);
  int _toFahrenheit(double celsius) => ((celsius * 9 / 5) + 32).round();
  String _formattedTemperature(double temp, TemperatureUnit temperatureUnit) =>
      temperatureUnit == TemperatureUnit.fahrenheit ? '${_toFahrenheit(temp)}°F'
          : '${temp.round()}°C';
  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    var oneDayFromNow = now.add(new Duration(days: daysFromNow));
   return Padding(
     padding: const EdgeInsets.only(left: 16.0),
     child: Container(
       decoration: BoxDecoration(
         color: Color.fromRGBO(205, 212, 228, 0.2),
         borderRadius: BorderRadius.circular(10),
       ),
       child: Padding(
         padding: const EdgeInsets.all(16.0),
         child: BlocBuilder<SettingBloc,SettingState>(
           builder: (context,settingState){
             return  Column(
               children: <Widget>[
                 Text(
                   new DateFormat.E().format(oneDayFromNow),
                   style: TextStyle(color: Colors.white, fontSize: 25),
                 ),
                 Text(
                   new DateFormat.MMMd().format(oneDayFromNow),
                   style: TextStyle(color: Colors.white, fontSize: 20),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                   child: Image.network(
                     'https://www.metaweather.com/static/img/weather/png/' +
                         weather.abbreviation +
                         '.png',
                     width: 50,
                   ),
                 ),
                 Text(
                   'High: ' + _formattedTemperature(weather.maxTemp, settingState.temperatureUnit) ,
                   style: TextStyle(color: Colors.white, fontSize: 20.0),
                 ),
                 Text(
                   'Low: ' + _formattedTemperature(weather.minTemp, settingState.temperatureUnit) ,
                   style: TextStyle(color: Colors.white, fontSize: 20.0),
                 ),
               ],
             );
           },
         )
       ),
     ),
   );
  }
}