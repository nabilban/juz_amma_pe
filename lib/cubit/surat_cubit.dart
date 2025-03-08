import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:juz_amma_pe/local/localstorage.dart';
import 'package:juz_amma_pe/model/audio_type.dart';
import 'package:juz_amma_pe/model/ayat.dart';
import 'package:juz_amma_pe/model/surat.dart';
import 'package:juz_amma_pe/network/endpoints.dart';
import 'package:juz_amma_pe/network/quran_ds.dart';

part 'surat_state.dart';
part 'surat_cubit.freezed.dart';

class SuratCubit extends Cubit<SuratState> {
  SuratCubit({
    required Surat surat,
    required this.localstorage,
    required this.quranDS,
  }) : super(SuratState(surat: surat)) {
    audioPlayer = AudioPlayer();
    if (!isClosed) {
      _playerStateSubscription = audioPlayer.playerStateStream.listen((event) {
        if (event.processingState == ProcessingState.completed) {
          emit(state.copyWith(playedAyat: null));
        }
      }, onError: (e) {
        emit(
          state.copyWith(errorMessage: 'Something went wrong : AudioPlayer'),
        );
      });

      _hapalanStreamSubscription = localstorage.hapalanStream.listen((data) {
        if (data.containsKey(surat.nomor)) {
          emit(state.copyWith(checkedAyatList: data[surat.nomor]!));
        } else {
          emit(state.copyWith(checkedAyatList: []));
        }
      }, onError: (e) {
        emit(state.copyWith(
            errorMessage: 'Something went wrong : LocalStorage'));
      });
    }
  }

  final QuranDS quranDS;
  final Localstorage localstorage;
  late final AudioPlayer audioPlayer;

  late final StreamSubscription _playerStateSubscription;
  late final StreamSubscription _hapalanStreamSubscription;

  @override
  Future<void> close() async {
    await _playerStateSubscription.cancel();
    await _hapalanStreamSubscription.cancel();
    audioPlayer.dispose();
    super.close();
  }

  Future<void> init() async {
    if (state.surat.nomor == null) {
      emit(state.copyWith(errorMessage: 'Surat not found'));
      return;
    }

    emit(state.copyWith(isLoading: true));

    try {
      final result = await quranDS.getAyatList(state.surat.nomor!);
      emit(state.copyWith(ayatList: result, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Something went wrong',
      ));
    }
  }

  void playAyat(Ayat ayat, AudioType audioType) {
    if (state.playedAyat != null && state.playedAyat != ayat) {
      audioPlayer.stop();
    }
    if (state.playedAyat == ayat) {
      audioPlayer.pause();
      emit(state.copyWith(playedAyat: null));
    } else {
      audioPlayer.setUrl(Endpoints.audioPartialUrlBuilder(
        state.surat.nomor ?? 0,
        ayat.no ?? 0,
        audioType,
      ));
      audioPlayer.play();
      emit(state.copyWith(playedAyat: ayat));
    }
  }

  void checkAyat(Ayat ayat) {
    localstorage.hapalanUpsert(state.surat.nomor ?? 0, ayat.no ?? 0);
  }
}
