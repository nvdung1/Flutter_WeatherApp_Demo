import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/theme_bloc.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/events/theme_event.dart';
import 'package:weather_app/events/weather_event.dart';
import 'package:weather_app/screens/search_screen.dart';
import 'package:weather_app/screens/setting_screen.dart';
import 'package:weather_app/screens/temperature_widget.dart';
import 'package:weather_app/screens/weathe_box.dart';
import 'package:weather_app/state/theme_state.dart';
import 'package:weather_app/state/weather_state.dart';
class WeatherScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WeatherScreen();
  }

}
class _WeatherScreen extends State<WeatherScreen>{
  late Completer<void> _completer;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<WeatherBloc>(context).add(
        WeatherEventBegin(city: 'ho chi minh')
    );
    _completer = Completer<void>();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Weather Today'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: (){
              Navigator.pushNamed(context, SettingScreen.routerName);
            },
          ),
          IconButton(
              onPressed: () async{
                final typedCity = await Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => SearchScreen()
                  ),
                );
                if(typedCity != null) {
                  BlocProvider.of<WeatherBloc>(context).add(
                      WeatherEventRequested(city: typedCity)
                  );
                }
              },
              icon: Icon(Icons.search)
          )
        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, weatherState){
              if(weatherState is WeatherStateSuccess){
                BlocProvider.of<ThemeBloc>(context).add(ThemeEventWeatherChanged(weatherCondition: weatherState.weather.weatherCondition));
                _completer.complete();
                _completer=Completer();
              }
          },
          builder: (context,weatherState){
            if(weatherState is WeatherStateLoading){
              return Center(child: CircularProgressIndicator());
            }if(weatherState is WeatherStateSuccess){
              final weather= weatherState.weather;
              return BlocBuilder<ThemeBloc,ThemeState>(builder: (context,themeState){
                return RefreshIndicator(

                  onRefresh: (){
                    BlocProvider.of<WeatherBloc>(context).add(
                        WeatherEventRefresh(city: weather.location)
                    );
                    //return a "Completer object"
                    return _completer.future;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: themeState.image,
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.6), BlendMode.dstATop),
                      )
                    ),
                    child: ListView(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.symmetric(vertical: 30),),
                            TemperatureWidget(
                              weather: weather,
                            ),

                            Text(
                              weather.location,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 2),),
                            Center(
                              child: Text(
                                'Updated: ${TimeOfDay.fromDateTime(weather.lastUpdated).format(context)}',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 30),),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: <Widget>[
                                  for (var i = 0; i < 7; i++)
                                    WeatherBox(
                                      daysFromNow: i+1,
                                      weather: weatherState.weatherToday[i],
                                    )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
                }
              );
            }
            if(weatherState is WeatherStateFailure){
              print("false");
              return Center(
                child: Text("Something went wrong !",style:  TextStyle(fontSize: 30,color: Colors.white ),),
              );
            }

            return Center(
              child: Text("Select a location first !",style:  TextStyle(fontSize: 30),),
            );
          },
        ),
      ),
    );
  }
  
}