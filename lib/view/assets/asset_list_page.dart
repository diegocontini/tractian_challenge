import 'package:flutter/material.dart';
import 'package:tractian_challenge/data/location_local_repository.dart';
import 'package:tractian_challenge/domain/models/constants/enum_unit.dart';
import 'package:tractian_challenge/shared/UI/color_custom.dart';
import 'package:tractian_challenge/view/assets/asset_list_controller.dart';
import 'package:tractian_challenge/view/assets/widgets/location_widget.dart';

class AssetListPage extends StatefulWidget {
  final EnumUnit unit;
  const AssetListPage({super.key, required this.unit});

  @override
  State<AssetListPage> createState() => _AssetListPageState();
}

class _AssetListPageState extends State<AssetListPage> {
  final controller = AssetListController(LocationLocalRepository());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      controller.fetchLocalizations(widget.unit);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorCustom.darkBlue,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Assets',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          return ListView.builder(
            itemCount: controller.localizations.length,
            itemBuilder: (context, index) {
              return LocationWidget(location: controller.localizations[index]);
            },
          );
        },
      ),
    );
  }
}
