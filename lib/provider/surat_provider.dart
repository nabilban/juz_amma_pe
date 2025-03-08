import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juz_amma_pe/cubit/surat_cubit.dart';
import 'package:juz_amma_pe/model/surat.dart';
import 'package:juz_amma_pe/pages/surat_page.dart';

class SuratScreen extends StatelessWidget {
  const SuratScreen({required this.surat, super.key});
  final Surat surat;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SuratCubit(
        localstorage: context.read(),
        quranDS: context.read(),
        surat: surat,
      ),
      child: SuratPage(),
    );
  }
}
