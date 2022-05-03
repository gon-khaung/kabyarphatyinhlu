import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lanpyathu/Methods/colors.dart';
import 'package:lanpyathu/Models/music.dart';
import 'package:lanpyathu/Widgets/page_manager.dart';
import 'package:lanpyathu/cubit/music_cubit.dart';
import 'package:lanpyathu/providers/music_provider.dart';

class PanelBottomWidget extends ConsumerStatefulWidget {
  const PanelBottomWidget({
    Key? key,
  }) : super(key: key);

  @override
  _PanelBottomWidgetState createState() => _PanelBottomWidgetState();
}

class _PanelBottomWidgetState extends ConsumerState<PanelBottomWidget> {
  late AudioPlayer _audioPlayer;
  late bool isPlaying;
  late PageManager _pageManager;
  late List<Music> musics = [];

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _pageManager = PageManager();
    ref.read(audioPlayerProvider);

    final musicCubit = MusicCubit();
    musicCubit.loadMusics();
    var state = musicCubit.stream;

    // state.listen((value) {
    //   if (value is LoadedMusic) {
    //     setState(() {
    //       musics = value.musics;
    //     });
    //     _audioPlayer
    //         .setAudioSource(ConcatenatingAudioSource(children: [
    //       for (var music in musics)
    //         AudioSource.uri(Uri.parse('asset:///src/${music.title}')),
    //     ]))
    //         .catchError((error) {
    //       // catch load errors: 404, invalid url ...
    //       print("An error occured $error");
    //     });
    //   }
    // });

    print(state);

    // Set a sequence of audio sources that will be played by the audio player.
    // if (musics.isNotEmpty) {
    //   _audioPlayer
    //       .setAudioSource(ConcatenatingAudioSource(children: [
    //     AudioSource.uri(Uri.parse('asset:///src/ghost.mp3')),
    //     // AudioSource.uri(Uri.parse(
    //     //     "https://archive.org/download/IGM-V7/IGM%20-%20Vol.%207/25%20Diablo%20-%20Tristram%20%28Blizzard%29.mp3")),
    //     // AudioSource.uri(Uri.parse(
    //     //     "https://archive.org/download/igm-v8_202101/IGM%20-%20Vol.%208/15%20Pokemon%20Red%20-%20Cerulean%20City%20%28Game%20Freak%29.mp3")),
    //     // AudioSource.uri(Uri.parse(
    //     //     "https://scummbar.com/mi2/MI1-CD/01%20-%20Opening%20Themes%20-%20Introduction.mp3")),
    //     for (var music in musics)
    //       AudioSource.uri(Uri.parse("asset:///src/${music.title}")),
    //   ]))
    //       .catchError((error) {
    //     // catch load errors: 404, invalid url ...
    //     print("An error occured $error");
    //   });
    // }
    // _audioPlayer.setAsset("src/ghost.mp3");
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void toggleMusicStatus() {}

  @override
  Widget build(BuildContext context) {
    final audioPlayer = ref.read(audioPlayerProvider);
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // swipable panel
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    margin: const EdgeInsets.only(top: 30),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(
                          image: AssetImage("src/Justice_Explicit.webp"),
                          fit: BoxFit.cover),
                    ),
                  ),

                  // NOTE: Title
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: StreamBuilder<int?>(
                      stream: _pageManager.currentMusicIndex,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          // get music title from index
                          var music = musics[snapshot.data!];
                          return Text(
                            //  display
                            music.title
                                .replaceAll("%20", " ")
                                .replaceAll(".mp3", ''),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child:
                                  const Icon(Icons.shuffle_rounded, size: 30),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Material(
                          color: Colors.transparent,
                          child: StreamBuilder<LoopMode>(
                              stream: _audioPlayer.loopModeStream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return InkWell(
                                    onTap: () {
                                      _audioPlayer.setLoopMode(
                                        LoopMode.values[
                                            (snapshot.data!.index + 1) % 2],
                                      );
                                    },
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50)),
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle),
                                      child: Icon(
                                        snapshot.data == LoopMode.off
                                            ? Icons.repeat
                                            : snapshot.data == LoopMode.one
                                                ? Icons.repeat_one_rounded
                                                : Icons.repeat_rounded,
                                        size: 30,
                                      ),
                                    ),
                                  );
                                }
                                return Container();
                              }),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: const Icon(Icons.favorite_outline_rounded,
                                  size: 30),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        // Material(
                        //   color: Colors.transparent,
                        //   child: InkWell(
                        //     onTap: () {},
                        //     borderRadius:
                        //         const BorderRadius.all(Radius.circular(50)),
                        //     child: Container(
                        //       width: 60,
                        //       height: 60,
                        //       decoration:
                        //           const BoxDecoration(shape: BoxShape.circle),
                        //       child: const Icon(Icons.library_music_rounded,
                        //           size: 30),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: StreamBuilder<Duration>(
                        stream: _pageManager.currentMusicDurationStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData &&
                              _audioPlayer.duration != null) {
                            var current = snapshot.data!;

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  // NOTE: double to int
                                  "${current.inMinutes} : ${current.inSeconds % 60}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${_audioPlayer.duration!.inMinutes} : ${_audioPlayer.duration!.inSeconds % 60}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            );
                          }
                          return const Text("");
                        },
                      ),
                    ),
                  ),

                  // Progress bar of the song with seek bar
                  Container(
                      child: StreamBuilder<Duration>(
                    stream: _pageManager.currentMusicDurationStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Slider(
                          activeColor: MyColor.secondaryColor,
                          // inactiveColor: MyColor.secondaryColor,
                          thumbColor: MyColor.primaryColor,
                          value: snapshot.data?.inSeconds.toDouble() ?? 0,
                          onChanged: (value) {
                            _pageManager.seek(Duration(seconds: value.toInt()));
                          },
                          onChangeEnd: (value) {
                            _pageManager.seek(Duration(seconds: value.toInt()));
                          },
                          min: 0,
                          max: _pageManager.duration?.inSeconds.toDouble() ?? 1,
                        );
                      }
                      return Container();
                    },
                  )),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              margin: const EdgeInsets.only(bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        // _audioPlayer.seekToPrevious();
                        _pageManager.previous();
                      },
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child:
                            const Icon(Icons.skip_previous_rounded, size: 40),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),

                  // NOTE: Play and Pause button
                  RotationTransition(
                    turns: const AlwaysStoppedAnimation(45 / 360),
                    child: Material(
                      color: MyColor.primaryColor,
                      shape: ShapeBorder.lerp(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        0.5,
                      ),
                      child: SizedBox(
                        child: ValueListenableBuilder<ButtonState>(
                            valueListenable: _pageManager.buttonNotifier,
                            builder: (_, value, __) {
                              return InkWell(
                                onTap: () {
                                  // if (playerState!.playing) {
                                  //   _audioPlayer.pause();
                                  // } else {
                                  //   _audioPlayer.play();
                                  // }
                                  if (value == ButtonState.playing) {
                                    _pageManager.pause();
                                  } else {
                                    _pageManager.play();
                                  }
                                },
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: RotationTransition(
                                    turns:
                                        const AlwaysStoppedAnimation(-45 / 360),
                                    child: Icon(
                                      value == ButtonState.playing
                                          ? Icons.pause_rounded
                                          : Icons.play_arrow_rounded,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 20,
                  ),

                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        // _audioPlayer.seekToNext();
                        _pageManager.next();
                      },
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: const Icon(Icons.skip_next_rounded, size: 40),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
