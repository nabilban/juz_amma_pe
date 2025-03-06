import 'package:freezed_annotation/freezed_annotation.dart';

part 'ayat.freezed.dart';
part 'ayat.g.dart';

@freezed
class Ayat with _$Ayat {
  const factory Ayat({
    @Default(0) @JsonKey(name: 'nomorAyat') int? no,
    @Default('') @JsonKey(name: 'teksArab') String? arab,
    @Default('') @JsonKey(name: 'teksLatin') String? latin,
    @Default('') @JsonKey(name: 'teksIndonesia') String? terjemahan,
  }) = _Ayat;

  factory Ayat.fromJson(Map<String, dynamic> json) => _$AyatFromJson(json);
}
