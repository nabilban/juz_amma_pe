import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:juz_amma_pe/cubit/main_cubit.dart';
import 'package:juz_amma_pe/model/surat.dart';
import 'package:juz_amma_pe/pages/settings_page.dart';
import 'package:juz_amma_pe/provider/doa_provider.dart';
import 'package:juz_amma_pe/widgets/surat_item.dart';

class MainPage extends StatefulHookWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isAsc = true;
  bool showOptions = false;
  List<Surat> suratList = [];

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<MainCubit>().init();
      return null;
    }, [context]);

    return Scaffold(
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

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.settings))
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                'assets/icon/icon.png', // Replace with your image path
                height: MediaQuery.of(context).size.height * 0.09,
              ),
              const SizedBox(width: 8),
              const Column(
                children: [
                  Text(
                    'Juz Amma PE',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Easy To Access Juz Amma',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              )
            ]),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: SearchBar(
                      hintText: 'Cari Surat',
                      padding: const WidgetStatePropertyAll(
                          EdgeInsets.only(left: 16)),
                      leading: const Icon(Icons.search),
                      trailing: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              showOptions = !showOptions;
                            });
                          },
                          icon: const Icon(Icons.more_vert),
                        ),
                      ],
                      onChanged: context.read<MainCubit>().search,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 5, // Adds shadow
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DoaProvider(),
                            ),
                          );
                        },
                        child: const Text('📖 Doa Doa'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Builder(builder: (context) {
                if (state.searchQuery.isNotEmpty) {
                  if (isAsc) {
                    suratList = state.filteredSuratList;
                  } else {
                    suratList = state.filteredSuratList.reversed.toList();
                  }
                } else {
                  if (isAsc) {
                    suratList = state.sortedSuratList;
                  } else {
                    suratList = state.sortedSuratList.reversed.toList();
                  }
                }

                return ListView.builder(
                  itemCount: suratList.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    return SuratItem(surat: suratList[index]);
                  },
                );
              }),
            ),
          ],
        );
      }),
    );
  }
}
