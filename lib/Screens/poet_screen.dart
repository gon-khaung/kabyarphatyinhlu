import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kabyarphatyinhlu/Methods/popup_player.dart';
import 'package:kabyarphatyinhlu/Models/music.dart';
import 'package:kabyarphatyinhlu/Screens/poet_screen_arguments.dart';
import 'package:kabyarphatyinhlu/providers/music_provider.dart';

class PoetScreen extends ConsumerStatefulWidget {
  const PoetScreen({Key? key}) : super(key: key);
  static const routeName = '/extractArguments';

  @override
  _PoetScreenState createState() => _PoetScreenState();
}

class _PoetScreenState extends ConsumerState<PoetScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as PoetScreenArguments;
    final playlists = ref.watch(playlistProvider);
    final audioPlayer = ref.watch(audioPlayerProvider);
    final totalPoems = playlists.asData!.value
        .where((element) => element.poet_id == arguments.poet.id)
        .length;
    final poemsByPoet = playlists.asData!.value
        .where((element) => element.poet_id == arguments.poet.id)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          arguments.poet.name,
          style: GoogleFonts.quicksand(fontSize: 14),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 1,
              right: 1,
              bottom: 116,
            ),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                arguments.poet.cover,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            arguments.poet.name,
                            maxLines: 2,
                            style: GoogleFonts.quicksand(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Text(
                            arguments.poet.description,
                            style: GoogleFonts.quicksand(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Text(
                            // if totalPoems more than 1, show totalPoems, else show 1
                            totalPoems > 1
                                ? '$totalPoems \n Poems'
                                : '$totalPoems \n Poem',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.quicksand(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 10,
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final currentIndex =
                          ref.watch(currentMusicIndex).value ?? 0;
                      final currentSequence =
                          ref.watch(currentSequenceStream).value;

                      final currentPoem =
                          currentSequence!.currentSource!.tag as Music;

                      final currentPoemIndex =
                          playlists.asData!.value.indexOf(poemsByPoet[index]);

                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            print(currentPoemIndex);
                            currentPoem != poemsByPoet[index]
                                ? audioPlayer.seek(
                                    Duration.zero,
                                    index: currentPoemIndex,
                                  )
                                : null;
                            // audioPlayer.play();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: currentPoem.id == poemsByPoet[index].id
                                  ? Theme.of(context).primaryColor
                                  : Colors.transparent,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image(
                                      image:
                                          AssetImage(poemsByPoet[index].cover),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        poemsByPoet[index].title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        poemsByPoet[index].artist,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
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
                                        index: currentPoemIndex,
                                      );

                                      if (audioPlayer.playing) {
                                        audioPlayer.stop();
                                      } else {
                                        audioPlayer.play();
                                      }
                                    },
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50)),
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle),
                                      child: Consumer(
                                        builder: (context, ref, child) {
                                          final playerState =
                                              ref.watch(audioPlayerState).value;
                                          return Icon(
                                              playerState != null
                                                  ? currentIndex ==
                                                              currentPoemIndex &&
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
                    childCount: totalPoems,
                  ),
                ),
              ],
            ),
          ),
          const PopupPlayer(),
        ],
      ),
    );
  }
}
