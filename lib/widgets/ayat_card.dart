import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juz_amma_pe/cubit/surat_cubit.dart';
import 'package:juz_amma_pe/extension/int.dart';
import 'package:juz_amma_pe/model/ayat.dart';

class AyatCard extends StatelessWidget {
  const AyatCard({
    super.key,
    required this.ayat,
  });

  final Ayat ayat;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SuratCubit, SuratState>(
      builder: (context, state) {
        return Card(
          margin: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 8,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          context.read<SuratCubit>().checkAyat(ayat);
                        },
                        icon: Icon(
                          Icons.check_circle,
                          color: state.isCurrentAyatChecked(ayat)
                              ? Colors.green[600]
                              : Colors.grey[400],
                        )),
                    CircleAvatar(
                      child: Text(
                        (ayat.no ?? 0).toArabic,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    IconButton.filled(
                        onPressed: () {
                          context.read<SuratCubit>().playAyat(ayat);
                        },
                        icon: Icon(
                          state.isCurrentAyatPlayed(ayat)
                              ? Icons.pause
                              : Icons.play_arrow,
                        ))
                  ],
                ),
                ListTile(
                  title: Text(
                    ayat.arab ?? '',
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  subtitle: Center(
                      child: Text(
                    ayat.latin ?? '',
                    textAlign: TextAlign.center,
                  )),
                ),
                Text('"${ayat.terjemahan}"'),
              ],
            ),
          ),
        );
      },
    );
  }
}
