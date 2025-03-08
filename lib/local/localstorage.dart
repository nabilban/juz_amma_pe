import 'package:flutter/material.dart';

abstract class Localstorage {
  Stream<Map<int, List<int>>> get hapalanStream;
  void hapalanUpsert(int nomorSurat, int ayat);
  Map<int, List<int>> getHapalan();

  Stream<ThemeMode> get themeModeStream;
  void updateThemeMode(ThemeMode themeMode);
  ThemeMode getThemeMode();
}
