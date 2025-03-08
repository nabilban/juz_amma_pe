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
    required this.audioPlayer,
  }) : super(SuratState(surat: surat)) {
    if (!isClosed) {
      audioPlayer.playerStateStream.listen((event) {
        if (event.processingState == ProcessingState.completed) {
          emit(state.copyWith(playedAyat: null));
        }
      }, onError: (e) {
        emit(
            state.copyWith(errorMessage: 'Something went wrong : AudioPlayer'));
      });

      localstorage.hapalanStream.listen((data) {
        if (data.containsKey(surat.nomor)) {
          emit(state.copyWith(checkedAyatList: data[surat.nomor]!));
        }
      }, onError: (e) {
        emit(state.copyWith(
            errorMessage: 'Something went wrong : LocalStorage'));
      });
    }
  }

  final QuranDS quranDS;
  final Localstorage localstorage;
  final AudioPlayer audioPlayer;

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

  void playAyat(Ayat ayat) {
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
        AudioType.abdulMuhsinAlQasim,
      ));
      audioPlayer.play();
      emit(state.copyWith(playedAyat: ayat));
    }
  }

  void checkAyat(Ayat ayat) {
    localstorage.hapalanUpsert(state.surat.nomor ?? 0, ayat.no ?? 0);
  }
}
