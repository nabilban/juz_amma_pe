import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:juz_amma_pe/local/localstorage.dart';

part 'theme_state.dart';
part 'theme_cubit.freezed.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({required this.localstorage}) : super(const ThemeState()) {
    if (!isClosed) {
      localstorage.themeModeStream.listen(
        (data) {
          emit(state.copyWith(themeMode: data));
        },
      );
    }
  }
  final Localstorage localstorage;

  void init() {
    final themeMode = localstorage.getThemeMode();
    emit(state.copyWith(themeMode: themeMode));
  }

  void changeTheme(ThemeMode? themeMode) {
    localstorage.updateThemeMode(themeMode ?? ThemeMode.system);
  }
}
