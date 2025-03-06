part of 'main_cubit.dart';

@freezed
class MainState with _$MainState {
  const factory MainState({
    @Default([]) List<Surat> suratList,
    @Default(false) bool isLoading,
    @Default(AudioType.abdullahAlJuhany) AudioType audioType,
    String? errorMessage,
  }) = _Initial;
}
