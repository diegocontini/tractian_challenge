import 'package:flutter/material.dart';
import 'package:tractian_challenge/data/asset_local_repository.dart';
import 'package:tractian_challenge/data/location_local_repository.dart';
import 'package:tractian_challenge/domain/models/constants/enum_unit.dart';
import 'package:tractian_challenge/shared/UI/color_custom.dart';
import 'package:tractian_challenge/shared/UI/size_helper.dart';
import 'package:tractian_challenge/view/assets/asset_list_controller.dart';
import 'package:tractian_challenge/view/assets/widgets/asset_widget.dart';
import 'package:tractian_challenge/view/assets/widgets/filter/filter_widget.dart';
import 'package:tractian_challenge/view/assets/widgets/location_widget.dart';

class AssetListPage extends StatefulWidget {
  final EnumUnit unit;
  const AssetListPage({super.key, required this.unit});

  @override
  State<AssetListPage> createState() => _AssetListPageState();
}

class _AssetListPageState extends State<AssetListPage> {
  final _controller = AssetListController(LocationLocalRepository(), AssetLocalRepository());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      _controller.fetchInitialData(widget.unit);
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
        listenable: _controller,
        builder: (context, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                FilterWidget(controller: _controller),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: SizeHelper.altura(context) * 0.7,
                  child: ListView(
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _controller.filteredLocations.length,
                        itemBuilder: (context, index) {
                          return LocationWidget(location: _controller.filteredLocations[index]);
                        },
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _controller.filteredUnlikedAssets.length,
                        itemBuilder: (context, index) {
                          return AssetWidget(asset: _controller.filteredUnlikedAssets[index]);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
