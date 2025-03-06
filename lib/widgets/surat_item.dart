import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juz_amma_pe/cubit/surat_cubit.dart';
import 'package:juz_amma_pe/model/surat.dart';
import 'package:juz_amma_pe/pages/surat_page.dart';

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
                builder: (_) => BlocProvider(
                      create: (context) => SuratCubit(
                        quranDS: context.read(),
                        surat: surat,
                      ),
                      child: const SuratPage(),
                    )));
      },
      title: Text('${surat.namaLatin} - ${surat.nama}'),
      subtitle: Text(surat.arti ?? ''),
    );
  }
}
