part of 'surat_cubit.dart';

@freezed
class SuratState with _$SuratState {
  const factory SuratState({
    @Default([]) List<Ayat> ayatList,
    required Surat surat,
    @Default(false) bool isLoading,
    Ayat? playedAyat,
    String? errorMessage,
    @Default([]) List<int> checkedAyatList,
  }) = _SuratState;
}

extension SuratStateExtension on SuratState {
  bool isCurrentAyatChecked(Ayat ayat) {
    return checkedAyatList.contains(ayat.no);
  }

  bool isCurrentAyatPlayed(Ayat ayat) {
    return playedAyat == ayat;
  }
}
