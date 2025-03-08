import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juz_amma_pe/cubit/main_cubit.dart';
import 'package:juz_amma_pe/cubit/theme_cubit.dart';
import 'package:juz_amma_pe/model/audio_type.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
      ),
      body: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return ListView(
            children: [
              ListTile(
                title: const Text('Pengisi Suara'),
                subtitle: const Text('Pengisi suara pembaca ayat'),
                trailing: DropdownButton<AudioType>(
                  alignment: Alignment.topCenter,
                  borderRadius: BorderRadius.circular(16),
                  value: state.audioType,
                  items: AudioType.values
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.name),
                          ))
                      .toList(),
                  onChanged: context.read<MainCubit>().updateAudioType,
                ),
              ),
              BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  return ListTile(
                    title: const Text('Tema'),
                    subtitle: const Text('Pilih tema aplikasi'),
                    trailing: DropdownButton<ThemeMode>(
                      alignment: Alignment.topCenter,
                      borderRadius: BorderRadius.circular(16),
                      value: state.themeMode,
                      items: ThemeMode.values
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.name.toCapitalCase()),
                              ))
                          .toList(),
                      onChanged: context.read<ThemeCubit>().changeTheme,
                    ),
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }
}
