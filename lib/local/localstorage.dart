import 'package:flutter/material.dart';

abstract class Localstorage {
  // Stream<List<int>> get doaStream;
  // void doaUpsert(int id);
  // Map<int, List<int>> getDoa();

  Stream<Map<int, List<int>>> get hapalanStream;
  void hapalanUpsert(int nomorSurat, int ayat);
  Map<int, List<int>> getHapalan();

  Stream<ThemeMode> get themeModeStream;
  void updateThemeMode(ThemeMode themeMode);
  ThemeMode getThemeMode();
}
