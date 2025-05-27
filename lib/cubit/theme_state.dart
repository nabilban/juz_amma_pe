part of 'theme_cubit.dart';

@freezed
class ThemeState with _$ThemeState {
  const factory ThemeState({
    required AppTheme appTheme,
    @Default(ThemeMode.system) ThemeMode themeMode,
  }) = _ThemeState;
}
