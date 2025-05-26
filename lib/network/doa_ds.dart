import 'package:juz_amma_pe/model/doa.dart';

abstract class DoaDs {
  Future<List<Doa>> getDoaList();
  Future<Doa> getDoaById(int id);
}
