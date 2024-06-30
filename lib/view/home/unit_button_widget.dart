import 'package:flutter/material.dart';
import 'package:tractian_challenge/domain/models/constants/enum_unit.dart';
import 'package:tractian_challenge/shared/UI/color_custom.dart';
import 'package:tractian_challenge/shared/navigation/animate_navigation.dart';
import 'package:tractian_challenge/view/assets/asset_list_page.dart';

class UnitButtonWidget extends StatelessWidget {
  final EnumUnit unit;
  const UnitButtonWidget({super.key, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 24),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              AnimateNavigation.nextPageFromRight(
                  page: AssetListPage(
                unit: unit,
              )));
        },
        child: Container(
          width: 317, //SizeHelper.largura(context) * 0.9,
          height: 76,
          decoration: const BoxDecoration(color: ColorCustom.blue, borderRadius: BorderRadius.all(Radius.circular(4))),
          child: Center(
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 24.0, right: 12),
                  child: Icon(
                    Icons.web_asset_sharp,
                    color: Colors.white,
                  ),
                ),
                Text(
                  unit.getDisplayableText,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
