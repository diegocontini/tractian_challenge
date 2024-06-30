import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tractian_challenge/view/assets/asset_list_controller.dart';

class TextSearchWidget extends StatelessWidget {
  final AssetListController _controller;
  const TextSearchWidget({super.key, required AssetListController controller}) : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: (value) {
        _controller.search(value.toString());
      },
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(12),
        prefixIcon: Icon(Icons.search),
        hintText: 'Buscar Ativo ou Local',
        filled: true,
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }
}
