import 'package:flutter/material.dart';

class SizeHelper {
  static double largura(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  static double altura(BuildContext context) {
    EdgeInsets padding = MediaQuery.paddingOf(context);

    return MediaQuery.sizeOf(context).height - (padding.top + padding.bottom);
  }
}
