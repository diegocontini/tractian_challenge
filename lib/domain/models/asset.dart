// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:core';

class Asset {
  String name;
  String id;
  String? parentId;
  String? locationId;
  String? sensorType;
  String? status;
  bool remove = false;
  List<Asset> children = [];
  Asset({
    required this.name,
    required this.id,
    this.parentId,
    this.locationId,
    this.sensorType,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'parentId': parentId,
      'locationId': locationId,
      'sensorType': sensorType,
      'status': status,
    };
  }

  factory Asset.fromMap(Map<String, dynamic> map) {
    return Asset(
      name: map['name'] as String,
      id: map['id'] as String,
      parentId: map['parentId'] != null ? map['parentId'] as String : null,
      locationId: map['locationId'] != null ? map['locationId'] as String : null,
      sensorType: map['sensorType'] != null ? map['sensorType'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }

  bool get isUnlinked {
    return locationId == null && parentId == null && sensorType != null;
  }

  bool get isComponent {
    return sensorType != null;
  }
}
