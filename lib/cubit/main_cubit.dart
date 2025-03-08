import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:juz_amma_pe/local/localstorage.dart';
import 'package:juz_amma_pe/model/audio_type.dart';
import 'package:juz_amma_pe/model/surat.dart';
import 'package:juz_amma_pe/network/quran_ds.dart';

part 'main_state.dart';
part 'main_cubit.freezed.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit({
    required this.quranDs,
    required this.localstorage,
  }) : super(const MainState()) {
    if (!isClosed) {
      _hapalanStreamSubscription = localstorage.hapalanStream.listen(
        updateHapalanView,
        onError: (e) {
          emit(state.copyWith(
            errorMessage: 'Something went wrong : LocalStorage',
          ));
        },
      );
    }
  }

  final QuranDS quranDs;
  final Localstorage localstorage;

  late final StreamSubscription _hapalanStreamSubscription;

  @override
  Future<void> close() async {
    await _hapalanStreamSubscription.cancel();
    super.close();
  }

  Future<void> init() async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await quranDs.getSuratList();
      final hapalan = localstorage.getHapalan();

      emit(state.copyWith(
        suratList: result.where((surat) => surat.nomor! >= 78).toList(),
        isLoading: false,
      ));

      updateHapalanView(hapalan);
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Something went wrong',
      ));
    }
  }

  void changeAudioType(AudioType audioType) {
    emit(state.copyWith(audioType: audioType));
  }

  void updateHapalanView(Map<int, List<int>> data) {
    final suratList = state.suratList.map((surat) {
      if (data.containsKey(surat.nomor)) {
        return surat.copyWith(
          totalHapalan: data[surat.nomor]?.length ?? 0,
        );
      }
      return surat.copyWith(totalHapalan: 0);
    }).toList();

    emit(state.copyWith(suratList: suratList));
  }

  void search(String value) {
    emit(state.copyWith(searchQuery: value));
  }

  void updateSortedBy(SortedBy? sortedBy) {
    emit(state.copyWith(sortedBy: sortedBy ?? SortedBy.nomorSurat));
  }

  void updateAudioType(AudioType? audioTupe) {
    emit(state.copyWith(audioType: audioTupe ?? AudioType.abdullahAlJuhany));
  }
}
