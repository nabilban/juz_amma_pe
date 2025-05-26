part of 'doa_cubit.dart';

@freezed
class DoaState with _$DoaState {
  const factory DoaState({
    @Default([]) List<Doa> doaList,
    Doa? doa,
    @Default(false) bool? isLoading,
    String? errorMessage,
  }) = _DoaState;
}
