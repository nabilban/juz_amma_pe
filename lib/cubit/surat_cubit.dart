import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:juz_amma_pe/model/ayat.dart';
import 'package:juz_amma_pe/model/surat.dart';
import 'package:juz_amma_pe/network/quran_ds.dart';

part 'surat_state.dart';
part 'surat_cubit.freezed.dart';

class SuratCubit extends Cubit<SuratState> {
  SuratCubit({
    required Surat surat,
    required this.quranDS,
  }) : super(SuratState(surat: surat));

  final QuranDS quranDS;

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
}
