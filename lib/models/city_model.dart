// Used for searching cities on the API

/*
{
        "id": 1125257,
        "name": "Mumbai",
        "region": "Maharashtra",
        "country": "India",
        "lat": 18.98,
        "lon": 72.83,
        "url": "mumbai-maharashtra-india"
    },
 */

import 'package:json_annotation/json_annotation.dart';

part 'city_model.g.dart';

@JsonSerializable()
class CityModel {
  final String name;
  final String country;

  CityModel({
    required this.name,
    required this.country,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => _$CityModelFromJson(json);
  Map<String, dynamic> toJson() => _$CityModelToJson(this);
}