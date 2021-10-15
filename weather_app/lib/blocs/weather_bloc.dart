import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/events/weather_event.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/repositories/weather_repositories.dart';
import 'package:weather_app/state/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent,WeatherState>{
  final WeatherRepositories weatherRepositories;
  WeatherBloc({required this.weatherRepositories}) : super(WeatherStateInitial());
  @override
  Stream<WeatherState> mapEventToState(WeatherEvent weatherEvent)async* {

    if(weatherEvent is WeatherEventBegin){
      yield WeatherStateLoading();
      try{
        final Weather weather = await weatherRepositories.getWeatherFromCity(weatherEvent.city);
        final List<Weather> listWeatherToday= await weatherRepositories.getWeatherOfWeek(weatherEvent.city);
        yield WeatherStateSuccess(weather: weather, weatherToday: listWeatherToday);
      }catch(exception){
        yield WeatherStateFailure();
      }
    }
    if(weatherEvent is WeatherEventRequested){
        yield WeatherStateLoading();
        try{
          final Weather weather = await weatherRepositories.getWeatherFromCity(weatherEvent.city);
          final List<Weather> listWeatherToday= await weatherRepositories.getWeatherOfWeek(weatherEvent.city);
          yield WeatherStateSuccess(weather: weather, weatherToday: listWeatherToday);
        }catch(exception){
          yield WeatherStateFailure();
        }
    }
    else if(weatherEvent is WeatherEventRefresh){
      try{
        final Weather weather = await weatherRepositories.getWeatherFromCity(weatherEvent.city);
        final List<Weather> listWeatherToday= await weatherRepositories.getWeatherOfWeek(weatherEvent.city);
        yield WeatherStateSuccess(weather: weather, weatherToday: listWeatherToday);
      }catch(exception){
        yield WeatherStateFailure();
      }

    }
  }


}