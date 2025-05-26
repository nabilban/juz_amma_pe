import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:juz_amma_pe/cubit/doa_cubit.dart';

class DoaPage extends StatefulHookWidget {
  const DoaPage({super.key});

  @override
  State<DoaPage> createState() => _DoaPageState();
}

class _DoaPageState extends State<DoaPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    useEffect(() {
      context.read<DoaCubit>().fetchDoaList();
      return null;
    }, [context]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kumpulan Doa'),
        centerTitle: true,
      ),
      body: BlocBuilder<DoaCubit, DoaState>(
        builder: (context, state) {
          if (state.isLoading == true) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.errorMessage != null) {
            return Center(
              child: Text(
                'Error: ${state.errorMessage}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return ListView.separated(
            itemCount: state.doaList.length,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final doa = state.doaList[index];
              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${doa.id} . ${doa.judul}',
                        style: textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        doa.arab ?? 'Teks Arab tidak tersedia',
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const Divider(height: 20, thickness: 1),
                      Text(
                        doa.terjemah ?? 'Terjemahan tidak tersedia',
                        style: textTheme.bodyMedium,
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
