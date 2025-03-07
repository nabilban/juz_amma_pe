import 'package:juz_amma_pe/model/ayat.dart';
import 'package:juz_amma_pe/model/surat.dart';

abstract class QuranDS {
  Future<List<Surat>> getSuratList();
  Future<List<Ayat>> getAyatList(int suratNo);
}
