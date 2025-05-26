import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:juz_amma_pe/model/doa.dart';
import 'package:juz_amma_pe/network/doa_ds.dart';

part 'doa_state.dart';
part 'doa_cubit.freezed.dart';

class DoaCubit extends Cubit<DoaState> {
  DoaCubit({required this.doaDs}) : super(const DoaState());

  final DoaDs doaDs;

  /// Fetch list of doa
  Future<void> fetchDoaList() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final list = await doaDs.getDoaList();
      emit(state.copyWith(doaList: list, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  /// Fetch doa by ID
  Future<void> fetchDoaById(int id) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final doa = await doaDs.getDoaById(id);
      emit(state.copyWith(doa: doa, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  /// Clear selected doa
  void clearSelectedDoa() {
    emit(state.copyWith(doa: null));
  }
}
