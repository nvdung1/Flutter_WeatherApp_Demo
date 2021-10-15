import 'package:equatable/equatable.dart';

enum TemperatureUnit{
  fahrenheit,
  celsius
}
class SettingState extends Equatable{
  final TemperatureUnit temperatureUnit;
  const SettingState({required this.temperatureUnit});
  @override
  // TODO: implement props
  List<Object?> get props => [temperatureUnit];
}