///DOCUMENTATION: https://equran.id/apidev/v2
library;

import 'package:juz_amma_pe/extension/int.dart';
import 'package:juz_amma_pe/model/audio_type.dart';

class Endpoints {
  Endpoints._();

  static const String baseUrl = 'https://equran.id/api/v2';
  static const String audioBaseUrl = 'https://equran.nos.wjv-1.neo.id';
  static String audioPartialUrlBuilder(
      int surat, int ayat, AudioType audioType) {
    return '$audioBaseUrl/audio-partial/${audioType.urlPart}/${surat.pad3()}${ayat.pad3()}.mp3';
  }
}
