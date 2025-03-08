import 'package:flutter/material.dart';

extension IntX on int {
  String pad3() {
    return toString().padLeft(3, '0');
  }

  String get toArabic {
    String res = '';

    final arabics = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    for (var element in '$this'.characters) {
      res += arabics[int.parse(element)];
    }

    return res;
  }
}
