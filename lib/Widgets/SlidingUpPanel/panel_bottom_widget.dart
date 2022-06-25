import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kabyarphatyinhlu/Methods/ad_helper.dart';
import 'package:kabyarphatyinhlu/Methods/colors.dart';
import 'package:kabyarphatyinhlu/Models/music.dart';
import 'package:kabyarphatyinhlu/providers/favorite_provider.dart';
import 'package:kabyarphatyinhlu/providers/music_provider.dart';

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
  late List<Music> musics = [];

  bool _isRewardedAdReady = false;
  bool _isUserClick = false;

  RewardedAd? _rewardedAd;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    ref.read(audioPlayerProvider);

    _loadRewardedAd();

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

  // AD
  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
        _rewardedAd = ad;
        ad.fullScreenContentCallback =
            FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
          setState(() {
            _isRewardedAdReady = false;
          });
          _loadRewardedAd();
        });
        setState(() {
          _isRewardedAdReady = true;
        });
      }, onAdFailedToLoad: (error) {
        print('Failed to load a rewarded ad: ${error.message}');
        setState(() {
          _isRewardedAdReady = false;
        });
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final audioPlayer = ref.read(audioPlayerProvider);
    final shuffleStatus = ref.watch(shuffleStream).value ?? false;

    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).brightness == Brightness.dark
              ? Theme.of(context).primaryColor
              : Colors.white,
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
                      child: Consumer(
                        builder: (context, ref, child) {
                          final currentMusic =
                              ref.watch(currentMusicIndex).value ?? 0;
                          final playlist = ref.watch(playlistProvider);
                          return playlist.when(
                            loading: () => const CircularProgressIndicator(),
                            error: (err, stack) => Text('Error: $err'),
                            data: (value) => Image(
                              image: AssetImage(
                                value[currentMusic].cover,
                              ),
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // NOTE: Title
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Consumer(
                      builder: (context, ref, child) {
                        final currentMusic =
                            ref.watch(currentMusicIndex).value ?? 0;
                        final playlist = ref.watch(playlistProvider);

                        return playlist.when(
                          loading: () => const CircularProgressIndicator(),
                          error: (err, stack) => Text('Error: $err'),
                          data: (value) => Text(
                            //  display
                            value[currentMusic]
                                .title
                                .replaceAll("%20", " ")
                                .replaceAll(".mp3", ''),
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                        );

                        // return const CircularProgressIndicator();
                      },
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              audioPlayer.setShuffleModeEnabled(!shuffleStatus);
                            },
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                shuffleStatus
                                    ? Icons.shuffle_on_rounded
                                    : Icons.shuffle_rounded,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Material(
                          color: Colors.transparent,
                          child: Consumer(builder: ((context, ref, child) {
                            final loopMode =
                                ref.watch(loopStream).value ?? LoopMode.off;
                            return InkWell(
                              onTap: () {
                                audioPlayer.setLoopMode(
                                  LoopMode.values[(loopMode.index + 1) % 2],
                                );
                              },
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                child: Icon(
                                  loopMode == LoopMode.off
                                      ? Icons.repeat
                                      : loopMode == LoopMode.one
                                          ? Icons.repeat_one_rounded
                                          : Icons.repeat_rounded,
                                  size: 25,
                                ),
                              ),
                            );
                          })),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Consumer(builder: (context, ref, child) {
                          final currentMusic =
                              ref.watch(currentMusicIndex).value ?? 0;
                          final playlist = ref.watch(playlistProvider);
                          final favorite = ref.watch(favoriteProvider);

                          return playlist.when(
                            data: (value) {
                              return Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    final favorite =
                                        ref.read(favoriteProvider.notifier);
                                    favorite.add(value[currentMusic]);
                                  },
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50)),
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle),
                                    child: Icon(
                                        favorite.contains(value[currentMusic])
                                            ? Icons.favorite_rounded
                                            : Icons.favorite_outline_rounded,
                                        size: 25),
                                  ),
                                ),
                              );
                            },
                            error: (d, t) => Text("Error: $d"),
                            loading: () {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );
                          // return Container();
                        }),
                        // const SizedBox(
                        //   width: 10,
                        // ),
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
                    margin: const EdgeInsets.only(top: 5),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Consumer(
                          builder: ((context, ref, child) {
                            final current =
                                ref.watch(currentPositionStream).value ??
                                    Duration.zero;

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  // NOTE: double to int
                                  "${twoDigits(current.inMinutes)} : ${twoDigits(current.inSeconds % 60)}",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  "${twoDigits(audioPlayer.duration != null ? audioPlayer.duration!.inMinutes : 00)} : ${twoDigits(audioPlayer.duration != null ? audioPlayer.duration!.inSeconds % 60 : 00)}",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            );
                          }),
                        )),
                  ),

                  // Progress bar of the song with seek bar
                  SizedBox(
                    // height: 10,
                    child: Consumer(
                      builder: (context, ref, child) {
                        final currentPosition =
                            ref.watch(currentPositionStream).value ??
                                Duration.zero;

                        return Slider(
                          activeColor: MyColor.secondaryColor,
                          // inactiveColor: MyColor.secondaryColor,
                          thumbColor: MyColor.primaryColor,
                          value: currentPosition.inSeconds.toDouble(),
                          onChanged: (value) {
                            audioPlayer.seek(Duration(seconds: value.toInt()));
                          },
                          onChangeEnd: (value) {
                            // _pageManager.seek(Duration(seconds: value.toInt()));
                            audioPlayer.seek(Duration(seconds: value.toInt()));
                          },
                          min: 0,
                          max: audioPlayer.duration != null
                              ? audioPlayer.duration!.inSeconds.toDouble()
                              : 0,
                        );
                      },
                    ),
                  ),
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
                        // audioPlayer.seekToPrevious();
                        // _pageManager.previous();
                        audioPlayer.stop();

                        if (_isRewardedAdReady) {
                          _rewardedAd?.show(
                            onUserEarnedReward: (_, reward) {
                              audioPlayer.seekToPrevious();
                              audioPlayer.play();
                            },
                          );
                        }
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
                        child: InkWell(
                          onTap: () {
                            // if (playerState!.playing) {
                            //   _audioPlayer.pause();
                            // } else {
                            //   _audioPlayer.play();
                            // }
                            // if (audioPlayer.playing) {
                            //   audioPlayer.pause();
                            // } else {
                            //   audioPlayer.play();
                            // }

                            // AD
                            if (audioPlayer.playing) {
                              audioPlayer.stop();
                            } else {
                              if (_isRewardedAdReady) {
                                _rewardedAd?.show(
                                  onUserEarnedReward: (_, reward) {
                                    audioPlayer.play();
                                  },
                                );
                              }
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
                              turns: const AlwaysStoppedAnimation(-45 / 360),
                              child: Consumer(
                                builder: (context, ref, child) {
                                  final playerState =
                                      ref.watch(audioPlayerState).value;
                                  return Icon(
                                    playerState != null
                                        ? playerState.playing
                                            ? Icons.pause_rounded
                                            : Icons.play_arrow_rounded
                                        : Icons.play_arrow_rounded,
                                    color: Colors.white,
                                    size: 40,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
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
                        // audioPlayer.seekToNext();
                        audioPlayer.stop();

                        if (_isRewardedAdReady) {
                          _rewardedAd?.show(
                            onUserEarnedReward: (_, reward) {
                              audioPlayer.seekToNext();
                              audioPlayer.play();
                            },
                          );
                        }
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

// Return Two Digit String
String twoDigits(int n) => n.toString().padLeft(2, "0");

class PoemCover extends ConsumerWidget {
  const PoemCover({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // AsyncValue<List<Music>> playlist = ref.watch(playlistProvider);

    final currentMusic = ref.watch(currentMusicIndex).value ?? 0;
    final playlist = ref.watch(playlistProvider);
    return playlist.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
      data: (value) => Image(
        image: AssetImage(
          value[currentMusic].cover,
        ),
        fit: BoxFit.cover,
      ),
    );

    // return const CircularProgressIndicator();
  }
}
