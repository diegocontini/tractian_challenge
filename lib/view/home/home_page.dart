import 'package:flutter/material.dart';
import 'package:tractian_challenge/domain/models/constants/enum_unit.dart';
import 'package:tractian_challenge/shared/UI/color_custom.dart';
import 'package:tractian_challenge/view/home/unit_button_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'TRACTIAN',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: ColorCustom.darkBlue,
      ),
      body: const Column(
        children: [
          Center(child: UnitButtonWidget(unit: EnumUnit.jaguar)),
          Center(child: UnitButtonWidget(unit: EnumUnit.tobias)),
          Center(child: UnitButtonWidget(unit: EnumUnit.apex)),
        ],
      ),
    );
  }
}
