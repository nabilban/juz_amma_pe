import 'package:freezed_annotation/freezed_annotation.dart';

part 'doa.freezed.dart';
part 'doa.g.dart';

@freezed
class Doa with _$Doa {
  const factory Doa({
    @Default(0) int? id,
    @Default('') String? judul,
    @Default('') String? latin,
    @Default('') String? arab,
    @Default('') String? terjemah,
  }) = _Doa;

  factory Doa.fromJson(Map<String, dynamic> json) => _$DoaFromJson(json);
}
