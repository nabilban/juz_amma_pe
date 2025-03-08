import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:juz_amma_pe/cubit/main_cubit.dart';
import 'package:juz_amma_pe/widgets/surat_item.dart';

class MainPage extends HookWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<MainCubit>().init();
    }, [context]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Juz Amma PE'),
        centerTitle: true,
      ),
      body: BlocBuilder<MainCubit, MainState>(builder: (context, state) {
        if (state.errorMessage != null) {
          return Center(
            child: Text(state.errorMessage!),
          );
        }

        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        return ListView.builder(
          itemCount: state.suratList.length,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) {
            return SuratItem(surat: state.suratList[index]);
          },
        );
      }),
    );
  }
}
