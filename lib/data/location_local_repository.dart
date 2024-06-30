import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:tractian_challenge/domain/models/constants/enum_unit.dart';
import 'package:tractian_challenge/domain/models/location.dart';
import 'package:tractian_challenge/domain/repository/location_repository.dart';

class LocationLocalRepository implements LocationRepository {
  @override
  Future<List<Location>> getAll(EnumUnit unit) async {
    List<Location> locations = [];

    String listString;
    switch (unit) {
      case EnumUnit.apex:
        listString = await rootBundle.loadString('assets/mock_data/Apex Unit/locations.json');
        break;
      case EnumUnit.jaguar:
        listString = await rootBundle.loadString('assets/mock_data/Jaguar Unit/locations.json');
        break;
      case EnumUnit.tobias:
        listString = await rootBundle.loadString('assets/mock_data/Tobias Unit/locations.json');
        break;
      default:
        listString = '';
    }

    final List<dynamic> json = jsonDecode(listString);

    locations = await compute((callback) async {
      for (var i in json) {
        var tempObj = Location.fromMap(i);

        locations.add(tempObj);
      }
      for (var location in locations) {
        var temp = locations.where((e) => e.parentId == location.id).toList();
        location.children = temp;
      }
      locations.removeWhere((e) => e.parentId != null);
      return locations;
    }, '');

    return locations;
  }
}
