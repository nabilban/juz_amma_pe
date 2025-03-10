import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:juz_amma_pe/cubit/surat_cubit.dart';
import 'package:juz_amma_pe/widgets/ayat_card.dart';

class SuratPage extends HookWidget {
  SuratPage() : super(key: Key('surat_page-${Random()}'));

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<SuratCubit>().init();
      return;
    }, [context]);

    return BlocBuilder<SuratCubit, SuratState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${state.surat.namaLatin} - ${state.surat.nama}'),
                Text('${state.surat.arti}',
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          body: Builder(builder: (_) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            if (state.errorMessage != null) {
              return Center(
                child: Text(state.errorMessage!),
              );
            }

            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              'بِسْمِ اللَّهِ الرحمن الرَّحِيمِ',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '"dengan menyebut nama Allah yang Maha Pengasih dan Maha Penyayang"',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
                SliverList.builder(
                    itemCount: state.ayatList.length,
                    itemBuilder: (context, index) {
                      return AyatCard(
                        ayat: state.ayatList[index],
                      );
                    }),
              ],
            );
          }),
        );
      },
    );
  }
}
