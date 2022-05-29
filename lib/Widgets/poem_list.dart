import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kabyarphatyinhlu/Models/music.dart';
import 'package:kabyarphatyinhlu/providers/music_provider.dart';

class PoemList extends StatelessWidget {
  const PoemList({
    Key? key,
    required this.playlist,
    required this.audioPlayer,
  }) : super(key: key);

  final List<Music> playlist;
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 1,
        right: 1,
        bottom: 100,
      ),
      child: Consumer(
        builder: (context, ref, child) {
          final currentIndex = ref.watch(currentMusicIndex).value ?? 0;
          final currentSequence = ref.watch(currentSequenceStream).value;

          if (currentSequence?.sequence.isEmpty ?? true) {
            // show loading
            return const Center(child: CircularProgressIndicator());
          }

          final currentPoem = currentSequence!.currentSource!.tag as Music;

          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (BuildContext context, int index) {
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    currentPoem != playlist[index]
                        ? audioPlayer.seek(Duration.zero, index: index)
                        : null;
                    // audioPlayer.play();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: currentPoem.id == playlist[index].id
                          ? Colors.blue[50]
                          : Colors.transparent,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image(
                              image: AssetImage(playlist[index].cover),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                playlist[index].title,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                playlist[index].artist,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              audioPlayer.seek(
                                Duration.zero,
                                index: index,
                              );

                              if (audioPlayer.playing) {
                                audioPlayer.stop();
                              } else {
                                audioPlayer.play();
                              }
                            },
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: Consumer(
                                builder: (context, ref, child) {
                                  final playerState =
                                      ref.watch(audioPlayerState).value;
                                  return Icon(
                                      playerState != null
                                          ? currentIndex == index &&
                                                  playerState.playing
                                              ? Icons.pause_rounded
                                              : Icons.play_arrow_rounded
                                          : Icons.play_arrow_rounded,
                                      size: 27);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
