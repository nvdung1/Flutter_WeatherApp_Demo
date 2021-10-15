import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/setting_bloc.dart';
import 'package:weather_app/events/setting_event.dart';
import 'package:weather_app/state/setting_state.dart';

class SettingScreen extends StatelessWidget{
  static const routerName ='/SettingsPage';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: ListView(
        children: [
          BlocBuilder<SettingBloc, SettingState>(
            builder: (context, settingState)
          => ListTile(
              title: Text("Temperature Unit"),
              isThreeLine: true,
              subtitle:Text(settingState.temperatureUnit==TemperatureUnit.celsius?
                                  'Celsius' : 'Fahrenheit'),
              trailing: Switch(
                value: settingState.temperatureUnit== TemperatureUnit.celsius,
                onChanged: (_){
                  BlocProvider.of<SettingBloc>(context).add(SettingEventToggleUnit());
                },
              ),
            )
          )
        ],
      ),
    );
  }
  
}