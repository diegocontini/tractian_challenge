import 'package:flutter/material.dart';
import 'package:tractian_challenge/domain/models/location.dart';

class LocationWidget extends StatelessWidget {
  final Location location;
  const LocationWidget({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        children: [const Icon(Icons.pin_drop), Text(location.name)],
      ),
      children: [
        ListView.builder(
          itemCount: location.children.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return LocationWidget(location: location.children[index] as Location);
          },
        )
      ],
    );
  }
}
