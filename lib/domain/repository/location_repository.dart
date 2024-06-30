import 'package:tractian_challenge/domain/models/constants/enum_unit.dart';
import 'package:tractian_challenge/domain/models/location.dart';

abstract interface class LocationRepository {
  Future<List<Location>> getAll(EnumUnit unit);
}
