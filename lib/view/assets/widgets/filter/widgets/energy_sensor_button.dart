import 'package:flutter/material.dart';
import 'package:tractian_challenge/shared/UI/color_custom.dart';
import 'package:tractian_challenge/view/assets/asset_list_controller.dart';

class EnergySensorButton extends StatelessWidget {
  final AssetListController _controller;
  const EnergySensorButton({super.key, required AssetListController controller}) : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, child) {
        bool isChecked = _controller.stateFilter == EnumAssetFilterState.sensor;
        return GestureDetector(
          onTap: () {
            _controller.onClickSensorFilter();
          },
          child: Container(
            width: 166, //SizeHelper.largura(context) * 0.9,

            height: 32,
            decoration: BoxDecoration(
                color: isChecked ? ColorCustom.blue : null,
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                border: const Border.fromBorderSide(BorderSide(
                  color: Colors.grey,
                ))),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.bolt,
                    color: isChecked ? Colors.white : Colors.grey,
                  ),
                  Text(
                    'Sensor de Energia',
                    style: TextStyle(
                      color: isChecked ? Colors.white : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
