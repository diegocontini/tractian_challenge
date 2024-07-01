import 'package:flutter/material.dart';
import 'package:tractian_challenge/domain/models/asset.dart';
import 'package:tractian_challenge/shared/UI/color_custom.dart';

class AssetWidget extends StatelessWidget {
  final Asset asset;
  const AssetWidget({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: asset.show,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: asset.isComponent ? Colors.transparent : null),
        child: ExpansionTile(
          title: Row(
            children: [
              Icon(
                !asset.isComponent ? Icons.view_in_ar : Icons.settings,
                color: ColorCustom.blue,
              ),
              Flexible(
                child: Text(
                  asset.name,
                  style: const TextStyle(fontSize: 14, overflow: TextOverflow.ellipsis),
                ),
              ),
              Builder(
                builder: (context) {
                  if (asset.status == 'alert') {
                    return const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(
                        Icons.circle,
                        color: Colors.red,
                        size: 10,
                      ),
                    );
                  }
                  if (asset.sensorType == 'energy') {
                    return const Icon(
                      Icons.bolt,
                      color: Colors.green,
                      size: 18,
                    );
                  }

                  return const SizedBox();
                },
              )
            ],
          ),
          trailing: asset.children.isNotEmpty ? null : const SizedBox(),
          onExpansionChanged: asset.children.isNotEmpty
              ? null
              : (value) {
                  //doNothing
                },
          children: [
            Visibility(
              visible: asset.children.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: asset.children.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return AssetWidget(asset: asset.children[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
