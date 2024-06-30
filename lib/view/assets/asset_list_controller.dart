import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tractian_challenge/domain/models/asset.dart';
import 'package:tractian_challenge/domain/models/constants/enum_unit.dart';
import 'package:tractian_challenge/domain/models/location.dart';
import 'package:tractian_challenge/domain/repository/asset_repository.dart';
import 'package:tractian_challenge/domain/repository/location_repository.dart';

enum EnumAssetListState { loading, ready, error }

enum EnumAssetFilterState { sensor, status, none }

class AssetListController extends ChangeNotifier {
  EnumAssetListState state = EnumAssetListState.loading;
  EnumAssetFilterState stateFilter = EnumAssetFilterState.none;
  EnumUnit? actualUnit;

  List<Location> locations = [];
  List<Location> filteredLocations = [];
  List<Asset> unlinkedAssets = [];
  List<Asset> filteredUnlikedAssets = [];
  final LocationRepository _locationRepository;
  final AssetRepository _assetRepository;
  AssetListController(this._locationRepository, this._assetRepository);
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

  void onClickSensorFilter() {
    if (stateFilter == EnumAssetFilterState.sensor) {
      stateFilter = EnumAssetFilterState.none;
      if (actualUnit != null) {
        fetchInitialData(actualUnit!);
      }
    } else {
      stateFilter = EnumAssetFilterState.sensor;
      search('filter');
    }
    notifyListeners();
  }

  void onClickStatusFilter() {
    if (stateFilter == EnumAssetFilterState.status) {
      stateFilter = EnumAssetFilterState.none;
      if (actualUnit != null) {
        fetchInitialData(actualUnit!);
      }
    } else {
      stateFilter = EnumAssetFilterState.status;
      search('filter');
    }
    notifyListeners();
  }

  Future<void> fetchInitialData(EnumUnit unit) async {
    actualUnit = unit;
    locations = await _locationRepository.getAll(unit);
    filteredLocations = locations.map((e) => e).toList();

    var assets = await _assetRepository.getAll(unit);
    unlinkedAssets = assets.unlinked;
    filteredUnlikedAssets = unlinkedAssets.map((e) => e).toList();
    _linkAssetWithLocation(assets: assets.linked, locations: locations);
    notifyListeners();
  }

  void _linkAssetWithLocation({required List<Asset> assets, required List<Location> locations}) {
    for (var location in locations) {
      location.assets = assets.where((e) => e.locationId == location.id).toList();
      if (location.children.isNotEmpty) {
        _linkAssetWithLocation(assets: assets, locations: location.children);
      }
    }
  }

  void search(String src) {
    if (src.isEmpty) {
      filteredLocations = locations;
    } else {
      filteredLocations = [];
      filteredUnlikedAssets = [];
      _searchLocation(src: src, locations: locations);

      _filterUnlinkedAssets(src: src, assets: unlinkedAssets);
    }
    notifyListeners();
  }

  bool _searchLocation({required String src, required List<Location> locations}) {
    bool findedLocation = false;

    if (locations.isNotEmpty) {
      for (var loc in locations) {
        if (loc.assets.isNotEmpty) {
          if (_searchAssetOrComponent(src: src, assets: loc.assets)) {
            if (!filteredLocations.contains(loc)) {
              filteredLocations.add(loc);
            }
          }
        }
        if (loc.children.isNotEmpty) {
          findedLocation = _searchLocation(src: src, locations: loc.children);
          if (_searchLocation(src: src, locations: loc.children)) {
            if (!filteredLocations.contains(loc)) {
              filteredLocations.add(loc);
            }
          }
        }
        if (loc.name.toLowerCase().contains(src.toLowerCase())) {
          log(loc.name);
          return true;
        }
      }
    }
    return findedLocation;
  }

  void _filterUnlinkedAssets({required String src, required List<Asset> assets}) {
    if (assets.isNotEmpty) {
      for (var asset in assets) {
        if (_searchAssetOrComponent(src: src, assets: assets)) {
          filteredUnlikedAssets.add(asset);
        }
      }
    }
  }

  bool _searchAssetOrComponent({required String src, required List<Asset> assets}) {
    bool finded = false;
    if (assets.isNotEmpty) {
      for (var asset in assets) {
        if (asset.children.isNotEmpty) {
          finded = _searchAssetOrComponent(src: src, assets: asset.children);
        }
        if (stateFilter == EnumAssetFilterState.sensor) {
          if (asset.sensorType == 'energy') {
            asset.remove = false;
            return true;
          }
        }
        if (stateFilter == EnumAssetFilterState.status) {
          if (asset.status == 'alert') {
            asset.remove = false;
            return true;
          }
        }
        if (asset.name.toLowerCase().contains(src.toLowerCase())) {
          asset.remove = false;
          return true;
        }
      }
    }
    return finded;
  }
}
