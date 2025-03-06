import 'dart:typed_data';

import 'package:juz_amma_pe/model/audio_type.dart';
import 'package:juz_amma_pe/model/ayat.dart';
import 'package:juz_amma_pe/model/surat.dart';

abstract class QuranDS {
  Future<List<Surat>> getSuratList();
  Future<List<Ayat>> getAyatList(int suratNo);
  Future<Uint8List> getAudioSurat({
    required int suratNo,
    required AudioType audioType,
  });
  Future<Uint8List> getAudioAyat({
    required int suratNo,
    required int ayatNo,
    required AudioType audioType,
  });
}
