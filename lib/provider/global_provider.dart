import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juz_amma_pe/cubit/main_cubit.dart';
import 'package:juz_amma_pe/cubit/theme_cubit.dart';
import 'package:juz_amma_pe/local/localstorage.dart';
import 'package:juz_amma_pe/local/localstorage_impl.dart';
import 'package:juz_amma_pe/network/doa_ds.dart';
import 'package:juz_amma_pe/network/doa_ds_impl.dart';
import 'package:juz_amma_pe/network/endpoints.dart';
import 'package:juz_amma_pe/network/quran_ds.dart';
import 'package:juz_amma_pe/network/quran_ds_impl.dart';
import 'package:juz_amma_pe/theme/theme.dart';
import 'package:juz_amma_pe/theme/util.dart';
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
    TextTheme textTheme = createTextTheme(context, "Arya", "Arya");

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
        Provider<DoaDs>(
            create: (context) => DoaDsImpl(
                    doaApi: Dio(
                  BaseOptions(
                    baseUrl: Endpoints.doaBaseUrl,
                  ),
                ))),
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
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider(
            create: (context) => MainCubit(
                  doaDs: context.read(),
                  quranDs: context.read(),
                  localstorage: context.read(),
                )),
        BlocProvider(
            create: (context) => ThemeCubit(
                  theme: AppTheme(textTheme),
                  localstorage: context.read(),
                )..init())
      ], child: child),
    );
  }
}
