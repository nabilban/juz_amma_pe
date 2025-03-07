import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:juz_amma_pe/local/localstorage.dart';
import 'package:juz_amma_pe/local/localstorage_impl.dart';
import 'package:juz_amma_pe/network/endpoints.dart';
import 'package:juz_amma_pe/network/quran_ds.dart';
import 'package:juz_amma_pe/network/quran_ds_impl.dart';
import 'package:provider/provider.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class GlobalProvider extends StatelessWidget {
  const GlobalProvider({
    super.key,
    required this.child,
    required this.preferences,
  });

  final Widget child;
  final StreamingSharedPreferences preferences;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<StreamingSharedPreferences>(
          create: (context) => preferences,
        ),
        Provider<Localstorage>(
          create: (context) => LocalstorageImpl(
            preferences: context.read(),
          ),
        ),
        Provider<QuranDS>(
          create: (context) => QuranDSImpl(
            quranApi: Dio(
              BaseOptions(
                baseUrl: Endpoints.baseUrl,
              ),
            ),
            audioApi: Dio(
              BaseOptions(
                baseUrl: Endpoints.audioBaseUrl,
              ),
            ),
          ),
        ),
        Provider(
          create: (context) => AudioPlayer(),
        ),
      ],
      child: child,
    );
  }
}
