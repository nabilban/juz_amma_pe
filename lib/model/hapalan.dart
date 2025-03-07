import 'package:freezed_annotation/freezed_annotation.dart';

part 'hapalan.freezed.dart';

@freezed
class Hapalan with _$Hapalan {
  const factory Hapalan({
    required int nomorSurat,
    required List<int> ayatList,
  }) = _Hapalan;
}
