import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/setting_bloc.dart';
// import 'package:weather_app/blocs/theme_bloc.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/state/setting_state.dart';
class TemperatureWidget extends StatelessWidget{
 final Weather weather;
  TemperatureWidget({Key? key,required this.weather}):super(key: key);
  int _toFahrenheit(double celsius) => ((celsius * 9 / 5) + 32).round();
 String _formattedTemperature(double temp, TemperatureUnit temperatureUnit) =>
     temperatureUnit == TemperatureUnit.fahrenheit ? '${_toFahrenheit(temp)}°F'
         : '${temp.round()}°C';
  @override
  Widget build(BuildContext context) {
    // Color _themeBloc= BlocProvider.of<ThemeBloc>(context).state.textColor;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: BlocBuilder<SettingBloc,SettingState>(
                builder: (context,settingState){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.network(
                        'https://www.metaweather.com/static/img/weather/png/' +
                            weather.abbreviation +
                            '.png',
                        width: 100,
                      ),
                      Text("${_formattedTemperature(weather.temp, settingState.temperatureUnit)}", style: TextStyle(color: Colors.white, fontSize: 60.0)),
                    ],
                  );
                },

              ),

            ),

          ],
        )
      ],
    );
  }

}