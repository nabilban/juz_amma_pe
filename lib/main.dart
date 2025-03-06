import 'package:flutter/material.dart';
import 'package:juz_amma_pe/app.dart';
import 'package:juz_amma_pe/provider/global_provider.dart';

void main() {
  runApp(
    const GlobalProvider(
      child: App(),
    ),
  );
}
