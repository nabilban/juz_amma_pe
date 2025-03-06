part of 'surat_cubit.dart';

@freezed
class SuratState with _$SuratState {
  const factory SuratState({
    @Default([]) List<Ayat> ayatList,
    required Surat surat,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _SuratState;
}
