import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:tractian_challenge/domain/models/asset.dart';
import 'package:tractian_challenge/domain/models/constants/enum_unit.dart';
import 'package:tractian_challenge/domain/models/location.dart';
import 'package:tractian_challenge/domain/repository/location_repository.dart';

class LocationLocalRepository {
  @override
  Future<({List<Asset> unlinked, List<Asset> linked})> getAll(EnumUnit unit) async {
    ({List<Asset> unlinked, List<Asset> linked}) record = (unlinked: [], linked: []);

    String listString;
    switch (unit) {
      case EnumUnit.apex:
        listString = await rootBundle.loadString('assets/mock_data/Apex Unit/assets.json');
        break;
      case EnumUnit.jaguar:
        listString = await rootBundle.loadString('assets/mock_data/Jaguar Unit/assets.json');
        break;
      case EnumUnit.tobias:
        listString = await rootBundle.loadString('assets/mock_data/Tobias Unit/assets.json');
        break;
      default:
        listString = '';
    }

    final List<dynamic> json = jsonDecode(listString);

    record = await compute((callback) async {
      ({List<Asset> unlinked, List<Asset> linked}) record = (unlinked: [], linked: []);
      for (var i in json) {
        var tempObj = Asset.fromMap(i);
        if (tempObj.locationId == null && tempObj.parentId == null) {
          record.unlinked.add(tempObj);
        } else {
          record.linked.add(tempObj);
        }
      }
      for (var location in record.linked) {
        var temp = record.linked.where((e) => e.parentId == location.id).toList();
        location.children = temp;
      }
      record.linked.removeWhere((e) => e.parentId != null);
      return record;
    }, '');

    return record;
  }
}
