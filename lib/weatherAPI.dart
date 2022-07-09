import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Model {
  final int? humidity;
  final double? pressure;
  final double? windSpeed;
  final String? name;
  final double? temp;
  const Model(
      {required this.humidity,                            //Model Class
      required this.pressure,
      required this.windSpeed,
      required this.name,
      required this.temp});
  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
        humidity: json['current']['humidity'],
        pressure: json['current']['pressure_in'],
        windSpeed: json['current']['wind_kph'],
        name: json['location']['name'],
        temp: json['current']['temp_c']);
  }
}
