import 'package:freezed_annotation/freezed_annotation.dart';

part 'surat.freezed.dart';
part 'surat.g.dart';

@freezed
class Surat with _$Surat {
  const factory Surat({
    @Default(0) int? nomor,
    @Default('') String? nama,
    @Default('') String? namaLatin,
    @Default(0) int? jumlahAyat,
    @Default('') String? tempatTurun,
    @Default('') String? arti,
    @Default('') String? deskripsi,
    @Default(0) int totalHapalan,
  }) = _Surat;

  factory Surat.fromJson(Map<String, dynamic> json) => _$SuratFromJson(json);
}
