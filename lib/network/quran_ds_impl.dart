import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:juz_amma_pe/extension/int.dart';
import 'package:juz_amma_pe/model/audio_type.dart';
import 'package:juz_amma_pe/model/ayat.dart';
import 'package:juz_amma_pe/model/surat.dart';
import 'package:juz_amma_pe/network/quran_ds.dart';

class QuranDSImpl extends QuranDS {
  QuranDSImpl({required this.quranApi, required this.audioApi});

  final Dio quranApi;
  final Dio audioApi;

  @override
  Future<List<Ayat>> getAyatList(int suratNo) {
    return quranApi.get('/surat/$suratNo').then((response) {
      final List<Ayat> ayatList = [];
      final List<dynamic> data = response.data['data']['ayat'];
      for (final ayat in data) {
        ayatList.add(Ayat.fromJson(ayat));
      }
      return ayatList;
    });
  }

  @override
  Future<List<Surat>> getSuratList() async {
    final response = await quranApi.get('/surat');
    final List<Surat> suratList = [];
    final List<dynamic> data = response.data['data'];
    for (final surat in data) {
      suratList.add(Surat.fromJson(surat));
    }
    return suratList;
    ;
  }

  @override
  Future<Uint8List> getAudioSurat({
    required int suratNo,
    required AudioType audioType,
  }) {
    return audioApi
        .get('/audio-full/${audioType.urlPart}/${suratNo.pad3()}.mp3',
            options: Options(responseType: ResponseType.bytes))
        .then((response) {
      return Uint8List.fromList(response.data);
    });
  }

  @override
  Future<Uint8List> getAudioAyat({
    required int suratNo,
    required int ayatNo,
    required AudioType audioType,
  }) {
    return audioApi
        .get('/audio-full/${audioType.urlPart}/${suratNo.pad3()}.mp3',
            options: Options(responseType: ResponseType.bytes))
        .then((response) {
      return Uint8List.fromList(response.data);
    });
  }
}
