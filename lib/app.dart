import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juz_amma_pe/cubit/main_cubit.dart';
import 'package:juz_amma_pe/pages/main_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Juz Amma PE',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => MainCubit(
          quranDs: context.read(),
        ),
        child: const MainPage(),
      ),
    );
  }
}
