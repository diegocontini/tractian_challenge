import 'package:flutter/material.dart';
import 'package:tractian_challenge/view/assets/asset_list_controller.dart';
import 'package:tractian_challenge/view/assets/widgets/filter/widgets/critical_button.dart';
import 'package:tractian_challenge/view/assets/widgets/filter/widgets/energy_sensor_button.dart';
import 'package:tractian_challenge/view/assets/widgets/filter/widgets/text_search_widget.dart';

class FilterWidget extends StatefulWidget {
  final AssetListController _controller;
  const FilterWidget({super.key, required AssetListController controller}) : _controller = controller;

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: const EdgeInsets.all(16.0), child: TextSearchWidget(controller: widget._controller)),
        Row(
          children: [
            const SizedBox(width: 16),
            EnergySensorButton(controller: widget._controller),
            const SizedBox(width: 16),
            CriticalButton(controller: widget._controller),
          ],
        )
      ],
    );
  }
}
