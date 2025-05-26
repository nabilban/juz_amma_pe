import 'package:dio/dio.dart';
import 'package:juz_amma_pe/model/doa.dart';
import 'package:juz_amma_pe/network/doa_ds.dart';

class DoaDsImpl extends DoaDs {
  DoaDsImpl({required this.doaApi});

  final Dio doaApi;

  @override
  Future<List<Doa>> getDoaList() {
    return doaApi.get('/doa').then((response) {
      final List<Doa> doaList = [];
      final List<dynamic> data = response.data;
      for (final ayat in data) {
        doaList.add(Doa.fromJson(ayat));
      }
      return doaList;
    });
  }

  @override
  Future<Doa> getDoaById(int id) {
    return doaApi.get('/doa/$id').then((response) {
      final data = response.data;
      return Doa.fromJson(data);
    });
  }
}
