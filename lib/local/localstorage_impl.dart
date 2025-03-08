import 'package:flutter/material.dart';
import 'package:juz_amma_pe/local/localstorage.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class LocalstorageImpl implements Localstorage {
  LocalstorageImpl({required this.preferences})
      : hapalanStringPreference =
            preferences.getStringList('hapalan', defaultValue: []),
        themePreference =
            preferences.getString('theme', defaultValue: 'system');

  final StreamingSharedPreferences preferences;

  final Preference<List<String>> hapalanStringPreference;
  final Preference<String> themePreference;

  @override
  Stream<Map<int, List<int>>> get hapalanStream {
    return hapalanStringPreference.asBroadcastStream().map((event) {
      if (event.isEmpty) {
        return {};
      }

      return _decodeHapalan(event);
    });
  }

  @override
  Map<int, List<int>> getHapalan() {
    return _decodeHapalan(hapalanStringPreference.getValue());
  }

  @override
  void hapalanUpsert(int nomorSurat, int ayat) {
    final Map<int, List<int>> hapalan =
        _decodeHapalan(hapalanStringPreference.getValue());

    final List<int> ayatList = hapalan[nomorSurat] ?? [];
    if (!ayatList.contains(ayat)) {
      ayatList.add(ayat);
    } else {
      ayatList.remove(ayat);
    }
    hapalan[nomorSurat] = ayatList;
    hapalanStringPreference.setValue(_encodeHapalan(hapalan));
  }

  Map<int, List<int>> _decodeHapalan(List<String> hapalanStrings) {
    Map<int, List<int>> result = {};

    for (String item in hapalanStrings) {
      // Split each string by ":" to get key and value
      List<String> parts = item.split(":");
      int key = int.parse(parts[0]);
      int value = int.parse(parts[1]);

      // If the key already exists in the map, add the value to its list
      // Otherwise, create a new list with the value
      if (result.containsKey(key)) {
        result[key]!.add(value);
      } else {
        result[key] = [value];
      }
    }

    return result;
  }

  List<String> _encodeHapalan(Map<int, List<int>> hapalan) {
    List<String> result = [];

    // Iterate through each entry in the map
    hapalan.forEach((key, values) {
      // For each value in the list, create a string in the format "key:value"
      for (int value in values) {
        result.add('$key:$value');
      }
    });

    return result;
  }

  @override
  Stream<ThemeMode> get themeModeStream =>
      themePreference.asBroadcastStream().map((event) {
        switch (event) {
          case 'light':
            return ThemeMode.light;
          case 'dark':
            return ThemeMode.dark;
          default:
            return ThemeMode.system;
        }
      });

  @override
  void updateThemeMode(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        themePreference.setValue('light');
        break;
      case ThemeMode.dark:
        themePreference.setValue('dark');
        break;
      case ThemeMode.system:
        themePreference.setValue('system');
        break;
    }
  }

  @override
  ThemeMode getThemeMode() {
    final data = themePreference.getValue();
    switch (data) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
