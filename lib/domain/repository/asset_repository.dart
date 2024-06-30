import 'package:tractian_challenge/domain/models/asset.dart';
import 'package:tractian_challenge/domain/models/constants/enum_unit.dart';

abstract interface class AssetRepository {
  Future<({List<Asset> unlinked, List<Asset> linked})> getAll(EnumUnit unit);
}
