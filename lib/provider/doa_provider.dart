import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juz_amma_pe/cubit/doa_cubit.dart';
import 'package:juz_amma_pe/pages/doa_page.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoaCubit(doaDs: context.read()),
      child: const DoaPage(),
    );
  }
}
