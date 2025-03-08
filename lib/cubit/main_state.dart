part of 'main_cubit.dart';

@freezed
class MainState with _$MainState {
  const factory MainState({
    @Default([]) List<Surat> suratList,
    @Default(false) bool isLoading,
    @Default(AudioType.abdullahAlJuhany) AudioType audioType,
    @Default('') String searchQuery,
    @Default(SortedBy.nomorSurat) SortedBy sortedBy,
    String? errorMessage,
  }) = _MainState;
}

extension MainStateX on MainState {
  List<Surat> get filteredSuratList {
    final searchValue = searchQuery.trim();

    return suratList
        .where((surat) =>
            surat.namaLatin!.toLowerCase().contains(searchValue.toLowerCase()))
        .toList();
  }

  List<Surat> get sortedSuratList {
    switch (sortedBy) {
      case SortedBy.nomorSurat:
        return filteredSuratList..sort((a, b) => a.nomor!.compareTo(b.nomor!));
      case SortedBy.hapalan:
        return filteredSuratList
          ..sort((a, b) => b.totalHapalan.compareTo(a.totalHapalan));
      case SortedBy.ayat:
        return filteredSuratList
          ..sort((a, b) => (b.jumlahAyat ?? 0).compareTo(a.jumlahAyat ?? 0));
    }
  }
}

enum SortedBy {
  nomorSurat('Nomor Surat'),
  hapalan('Total Hapalan'),
  ayat('Total Ayat');

  const SortedBy(this.label);
  final String label;
}
