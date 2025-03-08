import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juz_amma_pe/cubit/theme_cubit.dart';
import 'package:juz_amma_pe/pages/main_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Juz Amma PE',
          themeMode: state.themeMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: const MainPage(),
        );
      },
    );
  }
}
