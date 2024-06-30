import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:tractian_challenge/domain/models/constants/enum_unit.dart';
import 'package:tractian_challenge/domain/models/location.dart';
import 'package:tractian_challenge/domain/repository/location_repository.dart';

enum EnumAssetListState { loading, ready, error }

class AssetListController extends ChangeNotifier {
  EnumAssetListState state = EnumAssetListState.loading;
  List<Location> localizations = [];
  final LocationRepository _locationRepository;
  AssetListController(this._locationRepository);
  void setStateLoading() {
    state = EnumAssetListState.loading;
    notifyListeners();
  }

  void setStateReady() {
    state = EnumAssetListState.ready;
    notifyListeners();
  }

  void setStateError() {
    state = EnumAssetListState.error;
    notifyListeners();
  }

  Future<void> fetchLocalizations(EnumUnit unit) async {
    localizations = await _locationRepository.getAll(unit);
    notifyListeners();
  }
}
