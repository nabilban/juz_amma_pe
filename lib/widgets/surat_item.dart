import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juz_amma_pe/cubit/surat_cubit.dart';
import 'package:juz_amma_pe/model/surat.dart';
import 'package:juz_amma_pe/pages/surat_page.dart';
import 'package:juz_amma_pe/provider/surat_provider.dart';

class SuratItem extends StatelessWidget {
  const SuratItem({required this.surat, super.key});

  final Surat surat;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => SuratScreen(
                      surat: surat,
                    )));
      },
      title: Text('${surat.namaLatin} - ${surat.nama}'),
      subtitle: Text(surat.arti ?? ''),
    );
  }
}
