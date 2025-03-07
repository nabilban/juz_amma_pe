import 'package:flutter/material.dart';
import 'package:juz_amma_pe/app.dart';
import 'package:juz_amma_pe/provider/global_provider.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await StreamingSharedPreferences.instance;

  runApp(
    GlobalProvider(
      preferences: preferences,
      child: const App(),
    ),
  );
}
