import 'package:flutter/material.dart';
import 'package:tractian_challenge/domain/models/location.dart';
import 'package:tractian_challenge/shared/UI/color_custom.dart';
import 'package:tractian_challenge/view/assets/widgets/asset_widget.dart';

class LocationWidget extends StatelessWidget {
  final Location location;
  const LocationWidget({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        children: [
          const Icon(Icons.pin_drop, color: ColorCustom.blue),
          Expanded(
            child: Text(
              location.name,
              style: const TextStyle(fontSize: 14, overflow: TextOverflow.ellipsis),
            ),
          )
        ],
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: ListView.builder(
            itemCount: location.children.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return LocationWidget(location: location.children[index]);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: location.assets.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return AssetWidget(asset: location.assets[index]);
            },
          ),
        ),
      ],
    );
  }
}
