import 'package:flutter/material.dart';
import 'package:juz_amma_pe/extension/int.dart';
import 'package:juz_amma_pe/model/surat.dart';
import 'package:juz_amma_pe/provider/surat_provider.dart';

class SuratItem extends StatelessWidget {
  const SuratItem({required this.surat, super.key});

  final Surat surat;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => SuratScreen(
                          surat: surat,
                        )));
          },
          leading: Text(
            (surat.nomor ?? 0).toArabic,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          title: Text('${surat.namaLatin} - ${surat.nama}'),
          subtitle: Text(surat.arti ?? ''),
          trailing: Text('${surat.totalHapalan}/${surat.jumlahAyat}'),
        ),
        LinearProgressIndicator(
          value: surat.totalHapalan / (surat.jumlahAyat ?? 0),
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
          backgroundColor: Colors.grey[300],
        )
      ],
    );
  }
}
