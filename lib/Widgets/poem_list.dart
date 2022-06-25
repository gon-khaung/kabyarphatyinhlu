import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kabyarphatyinhlu/Methods/ad_helper.dart';
import 'package:kabyarphatyinhlu/Models/music.dart';
import 'package:kabyarphatyinhlu/providers/music_provider.dart';

class PoemList extends ConsumerStatefulWidget {
  const PoemList({
    Key? key,
    // required this.playlist,
    // required this.audioPlayer,
  }) : super(key: key);

  @override
  _PoemListState createState() => _PoemListState();
}

class _PoemListState extends ConsumerState<PoemList> {
  // late AsyncValue<List<Music>> playlist;

  // late RewardedAd mRewardedAd;
  bool _isRewardedAdReady = false;
  bool _isUserClick = false;

  RewardedAd? _rewardedAd;

  @override
  void initState() {
    super.initState();
    ref.read(audioPlayerProvider);
    ref.read(playlistProvider);
    // _addMusicToList();
    _loadRewardedAd();
  }

  // void _addMusicToList() {
  //   final _playlist = ref.watch(playlistProvider);

  //   _playlist.whenData((value) {
  //     setState(() {
  //       playlist = _playlist;
  //     });
  //   });
  // }

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
    final audioPlayer = ref.watch(audioPlayerProvider);
    final playlist = ref.watch(playlistProvider);

    // mRewardedAd.fullScreenContentCallback = FullScreenContentCallback(
    //   onAdShowedFullScreenContent: (RewardedAd ad) =>
    //       print('$ad onAdShowedFullScreenContent.'),
    //   onAdDismissedFullScreenContent: (RewardedAd ad) {
    //     print('$ad onAdDismissedFullScreenContent.');
    //     ad.dispose();
    //   },
    //   onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
    //     print('$ad onAdFailedToShowFullScreenContent: $error');
    //     ad.dispose();
    //   },
    //   onAdImpression: (RewardedAd ad) => print('$ad impression occurred.'),
    // );

    // mRewardedAd.show(
    //     onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
    //   // Reward the user for watching an ad.
    // });

    // if (_isRewardedAdReady) {
    //   return ElevatedButton(
    //     onPressed: () {
    //       showDialog(
    //         context: context,
    //         builder: (context) {
    //           return AlertDialog(
    //             title: const Text('Need a hint?'),
    //             content: const Text('Watch an Ad to get a hint!'),
    //             actions: [
    //               TextButton(
    //                 child: Text('cancel'.toUpperCase()),
    //                 onPressed: () {
    //                   Navigator.pop(context);
    //                 },
    //               ),
    //               TextButton(
    //                 child: Text('ok'.toUpperCase()),
    //                 onPressed: () {
    //                   Navigator.pop(context);
    //                   _rewardedAd?.show(
    //                     onUserEarnedReward: (_, reward) {
    //                       // QuizManager.instance.useHint();
    //                     },
    //                   );
    //                 },
    //               ),
    //             ],
    //           );
    //         },
    //       );
    //     },
    //     child: const Text("hint"),
    //   );
    // }

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

          return playlist.when(
            loading: () => const CircularProgressIndicator(),
            error: (err, stack) => Text('Error: $err'),
            data: (value) => ListView.builder(
              itemCount: value.length,
              itemBuilder: (BuildContext context, int index) {
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      currentPoem != value[index]
                          ? audioPlayer.seek(Duration.zero, index: index)
                          : null;
                      // audioPlayer.play();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: currentPoem.id == value[index].id
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
                          if (_isUserClick)
                            const Center(child: CircularProgressIndicator()),
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                image: AssetImage(value[index].cover),
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
                                  value[index].title,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  value[index].artist,
                                  style: Theme.of(context).textTheme.titleSmall,
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
                                // if (_isRewardedAdReady) {
                                //   _rewardedAd?.show(
                                //     onUserEarnedReward: (_, reward) {
                                // QuizManager.instance.useHint();
                                audioPlayer.seek(
                                  Duration.zero,
                                  index: index,
                                );
                                if (audioPlayer.playing) {
                                  if (currentIndex == index) {
                                    audioPlayer.stop();
                                  } else if (_isRewardedAdReady) {
                                    _rewardedAd?.show(
                                      onUserEarnedReward: (_, reward) {
                                        audioPlayer.play();
                                      },
                                    );
                                  }
                                } else {
                                  if (_isRewardedAdReady) {
                                    _rewardedAd?.show(
                                      onUserEarnedReward: (_, reward) {
                                        audioPlayer.play();
                                      },
                                    );
                                  }
                                }
                                //     },
                                //   );
                                // }

                                // // Ads
                                // RewardedAd.load(
                                //   adUnitId:
                                //       'ca-app-pub-3940256099942544/5224354917',
                                //   request: const AdRequest(),
                                //   rewardedAdLoadCallback:
                                //       RewardedAdLoadCallback(
                                //     onAdLoaded: (RewardedAd ad) {
                                //       print('$ad loaded.');
                                //       // Keep a reference to the ad so you can show it later.
                                //       // this._rewardedAd = ad;
                                //       // ad.show(
                                //       //   onUserEarnedReward: ((ad, reward) {
                                //       //     print(ad.responseInfo);
                                //       //   }),
                                //       // );

                                //       // this._rew

                                //     },
                                //     onAdFailedToLoad: (LoadAdError error) {
                                //       ScaffoldMessenger.of(context)
                                //           .showSnackBar(
                                //         const SnackBar(
                                //           content: Text(
                                //             "You need to watch to listen poems",
                                //           ),
                                //         ),
                                //       );
                                //     },
                                //   ),
                                // );
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
                                      size: 27,
                                    );
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
            ),
          );
          // if (playlist.value != null) {
          //   return Container();
          // }

          // if (playlist.value == null) {
          //   return const Center(child: CircularProgressIndicator());
          // }
        },
      ),
    );
  }
}

// Consumer(
//         builder: (context, ref, child) {
//           final currentIndex = ref.watch(currentMusicIndex).value ?? 0;
//           final currentSequence = ref.watch(currentSequenceStream).value;

//           if (currentSequence?.sequence.isEmpty ?? true) {
//             // show loading
//             return const Center(child: CircularProgressIndicator());
//           }

//           final currentPoem = currentSequence!.currentSource!.tag as Music;

//           // playlist.whenData(
//           //   (value) => ListView.builder(
//           //     itemCount: value.length,
//           //     itemBuilder: (BuildContext context, int index) {
//           //       return Material(
//           //         color: Colors.transparent,
//           //         child: InkWell(
//           //           onTap: () {
//           //             currentPoem != value[index]
//           //                 ? audioPlayer.seek(Duration.zero, index: index)
//           //                 : null;
//           //             // audioPlayer.play();
//           //           },
//           //           child: Container(
//           //             decoration: BoxDecoration(
//           //               color: currentPoem.id == value[index].id
//           //                   ? Colors.blue[50]
//           //                   : Colors.transparent,
//           //               borderRadius: const BorderRadius.all(
//           //                 Radius.circular(10),
//           //               ),
//           //             ),
//           //             padding: const EdgeInsets.all(8.0),
//           //             margin: const EdgeInsets.symmetric(
//           //                 horizontal: 10, vertical: 5),
//           //             child: Row(
//           //               children: [
//           //                 SizedBox(
//           //                   width: 50,
//           //                   height: 50,
//           //                   child: ClipRRect(
//           //                     borderRadius: BorderRadius.circular(10),
//           //                     child: Image(
//           //                       image: AssetImage(value[index].cover),
//           //                     ),
//           //                   ),
//           //                 ),
//           //                 const SizedBox(
//           //                   width: 10,
//           //                 ),
//           //                 Expanded(
//           //                   child: Column(
//           //                     crossAxisAlignment: CrossAxisAlignment.start,
//           //                     children: [
//           //                       Text(
//           //                         value[index].title,
//           //                         style: const TextStyle(
//           //                           fontSize: 14,
//           //                           fontWeight: FontWeight.bold,
//           //                         ),
//           //                       ),
//           //                       const SizedBox(
//           //                         height: 10,
//           //                       ),
//           //                       Text(
//           //                         value[index].artist,
//           //                         style: const TextStyle(
//           //                           color: Colors.black87,
//           //                           fontSize: 12,
//           //                         ),
//           //                         maxLines: 1,
//           //                       ),
//           //                     ],
//           //                   ),
//           //                 ),
//           //                 const SizedBox(
//           //                   width: 10,
//           //                 ),
//           //                 Material(
//           //                   color: Colors.transparent,
//           //                   child: InkWell(
//           //                     onTap: () {
//           //                       audioPlayer.seek(
//           //                         Duration.zero,
//           //                         index: index,
//           //                       );

//           //                       if (audioPlayer.playing) {
//           //                         audioPlayer.stop();
//           //                       } else {
//           //                         audioPlayer.play();
//           //                       }
//           //                     },
//           //                     borderRadius:
//           //                         const BorderRadius.all(Radius.circular(50)),
//           //                     child: Container(
//           //                       width: 60,
//           //                       height: 60,
//           //                       decoration:
//           //                           const BoxDecoration(shape: BoxShape.circle),
//           //                       child: Consumer(
//           //                         builder: (context, ref, child) {
//           //                           final playerState =
//           //                               ref.watch(audioPlayerState).value;
//           //                           return Icon(
//           //                               playerState != null
//           //                                   ? currentIndex == index &&
//           //                                           playerState.playing
//           //                                       ? Icons.pause_rounded
//           //                                       : Icons.play_arrow_rounded
//           //                                   : Icons.play_arrow_rounded,
//           //                               size: 27);
//           //                         },
//           //                       ),
//           //                     ),
//           //                   ),
//           //                 ),
//           //               ],
//           //             ),
//           //           ),
//           //         ),
//           //       );
//           //     },
//           //   ),
//           // );
//           if (playlist.value != null) {
//             return Container();
//           }

//           if (playlist.value == null) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           return const PlayList();
//         },
//       ),

class PlayList extends ConsumerWidget {
  const PlayList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Music>> playlist = ref.watch(playlistProvider);
    final currentIndex = ref.watch(currentMusicIndex).value ?? 0;
    final currentSequence = ref.watch(currentSequenceStream).value;
    final audioPlayer = ref.watch(audioPlayerProvider);

    if (currentSequence?.sequence.isEmpty ?? true) {
      // show loading
      return const Center(child: CircularProgressIndicator());
    }

    final currentPoem = currentSequence!.currentSource!.tag as Music;

    return playlist.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
      data: (value) {
        return ListView.builder(
          itemCount: playlist.value!.length,
          itemBuilder: (BuildContext context, int index) {
            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  currentPoem != playlist.value![index]
                      ? audioPlayer.seek(Duration.zero, index: index)
                      : null;
                  // audioPlayer.play();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: currentPoem.id == playlist.value![index].id
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
                            image: AssetImage(playlist.value![index].cover),
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
                              playlist.value![index].title,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              playlist.value![index].artist,
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
                            // final currentIndex =
                            //     ref.watch(currentMusicIndex).value ?? 0;
                            final currentSequence =
                                ref.watch(currentSequenceStream).value;

                            audioPlayer.seek(
                              Duration.zero,
                              index: index,
                            );

                            if (audioPlayer.playing) {
                              if (currentIndex == index) {
                                audioPlayer.stop();
                              }
                            } else {
                              audioPlayer.play();
                            }
                          },
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0)),
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
                                    size: 10);
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
    );
  }
}
