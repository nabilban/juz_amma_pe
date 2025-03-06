import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:juz_amma_pe/model/audio_type.dart';
import 'package:juz_amma_pe/model/ayat.dart';
import 'package:juz_amma_pe/network/endpoints.dart';
import 'package:provider/provider.dart';

class AyatCard extends StatefulWidget {
  const AyatCard({super.key, required this.ayat, required this.nomorSurat});

  final Ayat ayat;
  final int nomorSurat;

  @override
  State<AyatCard> createState() => _AyatCardState();
}

class _AyatCardState extends State<AyatCard> {
  bool isPlaying = false;
  bool isChecked = false;
  bool isOthersPlaying = false;

  @override
  Widget build(BuildContext context) {
    final audioSource = Endpoints.audioPartialUrlBuilder(
      widget.nomorSurat,
      widget.ayat.no ?? 0,
      AudioType.ibrahimAlDossari,
    );
    final player = context.read<AudioPlayer>();

    player.playbackEventStream.listen((event) {
      if (event.processingState == ProcessingState.loading && !isPlaying) {
        setState(() {
          isOthersPlaying = true;
        });
      } else if (event.processingState == ProcessingState.completed) {
        setState(() {
          isPlaying = false;
          isOthersPlaying = false;
        });
      }
    });

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                    icon: Icon(
                      Icons.check,
                      color: isChecked ? Colors.green[600] : Colors.grey[400],
                    )),
                CircleAvatar(child: Text('${widget.ayat.no}')),
                IconButton.filled(
                    onPressed: isOthersPlaying
                        ? null
                        : () {
                            context.read<AudioPlayer>().setUrl(
                                  audioSource,
                                );
                            if (isPlaying) {
                              context.read<AudioPlayer>().pause();
                            } else {
                              context.read<AudioPlayer>().play();
                            }
                            setState(() {
                              isPlaying = !isPlaying;
                            });
                          },
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                    ))
              ],
            ),
            ListTile(
              title: Text(
                widget.ayat.arab ?? '',
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              subtitle: Center(
                  child: Text(
                widget.ayat.latin ?? '',
                textAlign: TextAlign.center,
              )),
            ),
            Text('"${widget.ayat.terjemahan}"'),
          ],
        ),
      ),
    );
  }
}
