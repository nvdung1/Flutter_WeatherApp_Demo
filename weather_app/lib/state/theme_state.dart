
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable{
  final AssetImage image;
  const ThemeState({ required this.image});
  @override
  // TODO: implement props
  List<Object?> get props => [image];
}